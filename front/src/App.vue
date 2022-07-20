<template>
  <header>
    <!-- bar de nav -->
    <div class="wrapper">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <a class="navbar-brand" href="#">
            <img
              alt="Vue logo"
              class="logo"
              src="@/assets/logo.svg"
              width="150"
            />
          </a>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <RouterLink
                  to="/posts"
                  v-if="userStore.isAuthenticated"
                  class="nav-link"
                  >Posts</RouterLink
                >
              </li>
              <li class="nav-item">
                <RouterLink
                  to="/register"
                  v-if="!userStore.isAuthenticated"
                  class="nav-link"
                  >Register</RouterLink
                >
              </li>
              <li class="nav-item">
                <RouterLink
                  to="/login"
                  v-if="!userStore.isAuthenticated"
                  class="nav-link"
                  >Login</RouterLink
                >
              </li>
              <li class="nav-item">
                <RouterLink
                  to="/login"
                  v-if="userStore.isAuthenticated"
                  class="nav-link"
                  @click="disconnect"
                  >Se déconnecter</RouterLink
                >
              </li>
              <li class="nav-item" v-if="userStore.isAuthenticated">
                <button
                  type="button"
                  class="btn"
                  data-bs-toggle="modal"
                  data-bs-target="#Modal"
                >
                  {{ fullName }}
                </button>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <!-- lien de l'utilisateur-->
      <div
        class="modal fade"
        id="Modal"
        tabindex="-1"
        aria-labelledby="Modal"
        aria-hidden="true"
      >
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="Modal">{{ fullName }}</h5>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body">
              <p>Prénom : {{ user.firstName }}</p>
              <p>Nom : {{ user.lastName }}</p>
              <p>Email : {{ user.email }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  <main class="Allpost">
    <RouterView />
  </main>
</template>

<script setup>
import { ref, onUpdated, computed } from "vue";
import { RouterLink, RouterView } from "vue-router";
import { useApiService } from "./composable/apiService";
import { useRouter } from "vue-router";
import { useUserStore } from "./stores/user";

const apiService = useApiService();
const router = useRouter();
const userStore = useUserStore();

const user = ref([]);

const fullName = computed(() =>
  userStore.isAuthenticated ? userStore.userData.fullName : null
);

function disconnect() {
  userStore.disconnect();
  router.push("/login");
}

onUpdated(async () => {
  user.value = await apiService.seeMyProfile();
});
</script>

<style>
@import "@/assets/base.css";

.wrapper {
  border: 1px solid red;
}
.Allpost {
  display: flex;
 
  margin-left: 35%;
  align-items: center;
  display: flex;
  width: 500px;
  flex-direction: column;
}
</style>

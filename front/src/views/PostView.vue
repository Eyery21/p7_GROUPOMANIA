<template>
  <h1>Post</h1>
  <section>
    <h4>{{ post.firstname }} {{ post.lastname }}</h4>
    <h2>{{ post.title }}</h2>
    <p>{{ post.content }}</p>
    <img v-if="post.image" :src="post.image" class="card-img-top" alt="..." />
    <p>Posté le {{ post.date }} à {{ post.time }}</p>
      <RouterLink
        v-if="userStore.isAuthor(post.idAuthor)"
        :to="{ name: 'postFormUpdate', params: { id: postId } }"
        class="btn btn-primary"
        >Modifier</RouterLink
      >
      <button
        v-if="userStore.isAuthor(post.idAuthor)"
        class="btn btn-danger"
        @click="deletePost"
      >
        Supprimer
      </button>
  </section>
  <section id="section">
    <form class="flex-wrap" id="form" @submit.prevent="createComment(postId)">
      <textarea
        class="form-control"
        id="content"
        rows="1"
        v-model="content"
        placeholder="Ajouter un commentaire"
      ></textarea>
      <button type="submit" class="btn btn-success" id="btn" :class="disabled">
        Valider
      </button>
    </form>
    <CommentCard
      v-for="comment in comments"
      :key="comment.id"
      :comment="comment"
      @deleteComment="refreshComment"
      style="width: 100%"
    />
  </section>
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useApiService } from "../composable/apiService";
import CommentCard from "../components/CommentCard.vue";
import { useUserStore } from "../stores/user";

const apiService = useApiService();

const post = ref([]);
const comments = ref([]);
const route = useRoute();
const router = useRouter();
const content = ref("");
const disabled = computed(() => ({
  disabled: content.value == "",
}));
const postId = route.params.id;
const userStore = useUserStore();

async function deletePost() {
  const del = await apiService.deletePost(postId);
  router.push({
    name: "posts",
  });
  return del;
}
async function refreshComment() {
  comments.value = await apiService.getComments(postId);
}

async function createComment(postId) {
  const comment = await apiService.createComment(content, postId);
  comments.value = await apiService.getComments(postId);
  content.value = "";
  return comment;
}
onMounted(async () => {
  post.value = await apiService.getOnePost(postId);
  comments.value = await apiService.getComments(postId);
});
</script>
<style>

#content {
  width: 100%;
  height: 100px;
  margin-left: 8px;
  margin-top: 30px;
}
.card-img-top {
  max-height: 250px;
  max-width: 300px;
}
#form {
  display: flex;
  justify-content: center;
}
#btn {
  width: 30%;
  margin: 30px;
}
img {
  display: block;
  max-height: 600px;
  max-width: 800px;
  margin: 20px auto;
}

</style>

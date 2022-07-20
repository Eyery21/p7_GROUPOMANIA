const tokenKey = 'token'
const userKey = 'user'

export function useLocalStorageService() {


    // création du token et stockage
    function setItems(token, user) {
        localStorage.setItem(tokenKey, token);
        localStorage.setItem(userKey, JSON.stringify(user));
    }

        // 
    function getUser() {
        const user = localStorage.getItem(userKey)
        const decodedUser = JSON.parse(user);
        return decodedUser

    }
    
    function removeUser() {
        localStorage.removeItem(tokenKey);
        localStorage.removeItem(userKey)
    }

    function getToken() {

        return localStorage.getItem(tokenKey)
    }

    return {
        setItems,
        getUser,
        removeUser,
        getToken
    }

}
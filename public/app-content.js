Vue.component("go-app-content", {
    data: () => {
        return {
            
        }
    },

    created() {
        this.$wsocket.send({
            "command": "fetch"
        });
    },

    template: `
    <v-main>  
        <v-app-bar app>
            <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>Application</v-toolbar-title>
        </v-app-bar>
    </v-main>
    `
})
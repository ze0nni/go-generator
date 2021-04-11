Vue.component("go-app", {
    template: `
    <v-app>
      <v-app-bar app>
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
        <v-toolbar-title>Application</v-toolbar-title>
      </v-app-bar>
      <v-main>  
        <v-container>
            hello
        </v-container>
      </v-main>
    </v-app>
    `
})
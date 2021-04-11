Vue.component("go-app", {
    data: () => {
        return {
            isConnected: false,
            disconnectedCode: 0
        }
    },

    webSockets: {
        connected() {
            this.isConnected = true;
        },
        disconnected(code) {
            this.isConnected = false;
            this.disconnectedCode = code
        },

        command: {

        }
    },

    template: `
    <v-app>
        <v-container v-if="!isConnected">
            <v-alert
            border="left"
            type="info"
            >Connecting...</v-alert>
            <v-alert v-if="disconnectedCode"
            border="left"
            type="warning"
            >Error code: {{disconnectedCode}}</v-alert>
        </v-container>
        <go-app-content v-if="isConnected">  
        </go-app-content>
    </v-app>
    `
})
<template lang="pug">
div
  form
    div
      input(placeholder='ex) naoya', v-model='contributor')
      input(placeholder='ex) react', v-model='showNote')
  article
    EpisodeItem(v-for='episode in filteredUsers',
                :key='episode.id',
                :episode='episode',
                :on-click='onClickShowNoteLink')
</template>

<script>
import axios from 'axios'
import EpisodeItem from './EpisodeItem.vue'
export default {
  components: {
    EpisodeItem
  },

  data () {
    return {
      contributor: '',
      showNote: '',
      episodes: []
    }
  },

  mounted () {
    axios.get('/episodes').then((response) => {
      this.$data.episodes = response.data.map(
        d => ({ ...d, show: false })
      )
    });
  },

  computed: {
    filteredUsers: function () {
      return this.episodes.filter((ep) => (
        ep.contributor_text.indexOf(this.contributor) !== -1 &&
          ep.show_note_full_text.indexOf(this.showNote) !== -1
      ));
    }
  },

  methods: {
    onClickShowNoteLink({id, show}) {
      this.$data.episodes = this.$data.episodes.map(
        e => (e.id === id ? { ...e, show: !show } : e)
      )
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

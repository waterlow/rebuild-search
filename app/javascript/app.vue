<template lang="pug">
div
  b-form(inline='')
    label.sr-only(for='name') Name
    b-input#name.mb-2.mr-sm-2.mb-sm-0(placeholder='hak' v-model='contributor')
    label.sr-only(for='shownote') Shownote
    b-input#shownote.mb-2.mr-sm-2.mb-sm-0(placeholder='React' v-model='showNote')
  article.episodes
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

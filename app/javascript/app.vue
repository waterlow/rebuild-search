<template lang="pug">
div
  form
    div
      input(placeholder='ex) naoya', v-model='contributor')
      input(placeholder='ex) react', v-model='showNote')
  article(v-for='episode in filteredUsers')
    h2 {{ episode.title }}
    p {{ episode.description }}
    div(v-show='episode.show')
      a(href='#', @click.prevent='onClickShowNoteLink(episode)') show noteを閉じる
      p(v-for='show_note in episode.show_notes')
        a(:href='show_note.url') {{show_note.text}}
    div(v-show='!episode.show')
      a(href='#', @click.prevent='onClickShowNoteLink(episode)') show noteを開く
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      contributor: '',
      showNote: '',
      episodes: []
    }
  },

  mounted () {
    axios.get('/episodes.json').then((response) => {
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

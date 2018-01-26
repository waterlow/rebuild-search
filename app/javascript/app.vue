<template>
  <div>
    <form>
      <div>
        <input placeholder="ex) naoya" v-model="contributor"></input>
        <input placeholder="ex) react" v-model="showNote"></input>
      </div>
    </form>

    <article v-for="episode in filteredUsers">
      <h2>{{ episode.title }}</h2>
      <p>{{ episode.description }}</p>
      <a href="#">show noteを開く</a>
    </article>
  </div>
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
      this.$data.episodes = response.data;
    });
  },

  computed: {
    filteredUsers: function () {
      return this.episodes.filter((ep) => (
        ep.contributor_text.indexOf(this.contributor) !== -1 &&
          ep.show_note_full_text.indexOf(this.showNote) !== -1
      ));
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

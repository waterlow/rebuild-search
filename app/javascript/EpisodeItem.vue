<template lang="pug">
div
  h2 {{ episode.title }}
  p {{ episode.description }}
  div(v-show='episode.show')
    a(href='#', @click.prevent='onClick(episode)') show noteを閉じる
    p(v-for='show_note in episode.show_notes')
      a(:href='show_note.url') {{show_note.text}}
  div(v-show='!episode.show')
    a(href='#', @click.prevent='onClick(episode)') show noteを開く
</template>

<script>
export default {
  props: {
    episode: {
      type: Object,
      required: true
    },
    onClick :{
      type: Function,
      required: true
    }
  }

}
</script>

<template>
  <div>
    <form>
      <div>
        <input placeholder="ex) naoya"></input>
        <input placeholder="ex) react"></input>
      </div>
    </form>

    <ol>
      <li v-for="todo in todos">
        {{ todo.text }}
      </li>
    </ol>
  </div>
</template>

<script>
export default {
  data: ()=> ({
    todos: [
      { text: 'Learn JavaScript' },
      { text: 'Learn Vue' },
      { text: 'Build something awesome' }
    ]
  }),

}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

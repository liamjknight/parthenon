<template>
  
   
    <div id= "easy-access" class="qlbox"> 
       <div id="unique-welcome" class="welcomemessage">Welcome, {{ $store.state.user.username }}</div>
      <div v-for="course in this.courses" v-bind:key="course.id" class="quick-links">
        <h3 class="qlheads">{{ course.name }}</h3>
        <router-link tag="div" class="mainlink" :to="{ name: 'course', params: {id: course.id} }">View Details</router-link>
      </div>
    </div>
</template>

<script>
import courseService from "@/services/CourseService.js";

export default {
  name: "quick-links",
  data() {
    return {
      errorMsg: "",
      courses: []
    }
  },
  methods: {
    makeCourseList() {
      courseService.list().then(response => {
        response.data.forEach((course)=>{this.courses.push(course);});
      });
    },
  },
  created() {
    this.makeCourseList();
  }
}
</script>

<style scoped>

.welcomemessage{
    display: flex;
    width: 100%;
    height: 1%;
    font-weight: bolder;
    font-size: 50px;
    
}
.mainlink:hover{
    cursor: pointer;
}
.qlbox {
    display: flex;
    
    flex-flow: row wrap;
    width: 100%;
    height: 45vh;
    justify-content: flex-start;
    margin-top: 15px;
    margin-bottom: 0px;
}

.qlheads {
  margin-bottom: 0px;
  text-align: center;
}

  #all-courses-table-caption{
    font-size: 30px;
  }
  .table-rows{
    font-size: 20px;
  }

  .quick-links{
    color:rgb(175, 198, 216);
    border: solid gold;
    text-align: center;
    font-size: 20px;
    font-variant-caps: petite-caps;
    border: solid black;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    margin-top: 10px;
    margin-right: auto;
    margin-left: auto;
    border-radius: 20px;
    background-color:#3a3535;
    opacity: 80%;
    width: 10em;
    height: 10em;
  }
  /* .mainlink::before{
    content: " ";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
} */

  .quick-links:nth-child(even){
    background-color: rgb(67, 136, 141);
    opacity: 80%;
    color: black;
  }
</style>
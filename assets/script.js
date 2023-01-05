const url = "http://localhost:3000/api/exams"
const tbory = document.getElementById("tbory") 

fetch(url)
    .then((res) => {
        return res.json()
    })
    .then((exams) => {
        exams.forEach(exam => {
            tbory.innerHTML +=`
                <tr>
                    <td>${exam.token}</td>
                    <td>${exam.medical_crm}</td>
                    <td>${exam.name}</td>
                    <td>${exam.taxpayer_registry}</td>
                    <td>${exam.address}</td>
                    <td>${exam.city}/${exam.state}</td>
                    <td>${exam.type_of_exam}</td>
                    <td>${exam.limits}</td>
                    <td>${exam.result}</td>
                </tr>`
        })
    })
const url = "http://localhost:3000/api/exams"

function formatDate(date){
    return date.split("-").reverse().join("/")
}

fetch(url)
    .then((res) => {
        return res.json()
    })
    .then((exams) => {
        exams.forEach(exam => {
            const tBory = document.getElementById("tbory") 
            let newRow = tBory.insertRow(-1)
            newRow.insertCell(0).textContent = `${exam.token}`
            newRow.insertCell(1).textContent = `${exam.medical_crm}`
            newRow.insertCell(2).textContent = `${exam.name}`
            newRow.insertCell(3).textContent = `${exam.taxpayer_registry}`
            newRow.insertCell(4).textContent = `${formatDate(exam.exam_date)}`
            newRow.insertCell(5).textContent = `${exam.city}/${exam.state}`
            newRow.insertCell(6).textContent = `${exam.type_of_exam}`
            newRow.insertCell(7).textContent = `${exam.limits}`
            newRow.insertCell(8).textContent = `${exam.result}`
        })
    })
    .catch(() => {
        const reportError = document.getElementById("error") 
        reportError.classList.add("alert", "alert-warning")
        reportError.textContent = "Ops, ocorreu um erro."
  })
let token = document.getElementById("token").textContent
const url = `http://localhost:3000/api/exams/${token}`
const tBory = document.getElementById("tbory") 
const ul = document.getElementById("ul")

fetch(url)
    .then((res) => {
        return res.json()
    })
    .then((exams) => {
        let medicalCrm = document.createElement("li")
        medicalCrm.textContent = `CRM Médico: ${exams[0].medical_crm}`
        medicalCrm.classList.add("list-group-item", "bg-dark", "text-light")
        ul.appendChild(medicalCrm)

        let name = document.createElement("li")
        name.textContent = `Nome: ${exams[0].name}`
        name.classList.add("list-group-item", "bg-dark", "text-light")
        ul.appendChild(name)

        let taxpayerRegistry = document.createElement("li")
        taxpayerRegistry.textContent = `Cpf: ${exams[0].taxpayer_registry}`
        taxpayerRegistry.classList.add("list-group-item", "bg-dark", "text-light")
        ul.appendChild(taxpayerRegistry)

        let examDate = document.createElement("li")
        examDate.textContent = `Data do Exame: ${formatDate(exams[0].exam_date)}`
        examDate.classList.add("list-group-item", "bg-dark", "text-light")
        ul.appendChild(examDate)

        let cityState = document.createElement("li")
        cityState.textContent = `Cidade/Estado: ${exams[0].city}/${exams[0].state}`
        cityState.classList.add("list-group-item", "bg-dark", "text-light")
        ul.appendChild(cityState)

        exams.forEach(exam => {
            let newRow = tBory.insertRow(-1)
            newRow.insertCell(0).textContent = `${exam.type_of_exam}`
            newRow.insertCell(1).textContent = `${exam.limits}`
            newRow.insertCell(2).textContent = `${exam.result}`
        })
    })
    .catch((error) => {
        console.log(error)
        const reportError = document.getElementById("error") 
        reportError.classList.add("alert", "alert-warning")
        reportError.textContent = "Ops, ocorreu um erro."
    })
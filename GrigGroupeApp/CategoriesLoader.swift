import Foundation

// Можем написать функцию, чтобы не говорить как она будет реализована
protocol CategoriesLoaderDelegate {
    func loaded(categories: [Category])
}

class CategoriesLoader{
    
    var delegate: CategoriesLoaderDelegate?
    func loadCategories(){
        
        // передаём ссылку. причём мы уверены что она будет корректна
     //   let url = URL(string: "https://blackstarshop.ru/index.php?route =api/v1/categories")!
        
        //Делаем запрос
      //  var request = URLRequest(url: url)
        
        //По умолчанию запос имеет тип ГЕТ
        //request.httpMethod = "POST"
        
        //Мы могли бы записать хедеры
        //request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        
        //
        //request.httpBody =
        
        
        //в дату всегда приходит ответ, который мы получили от сервера.джейсон код
     //   let task = URLSession.shared.dataTask(with:request) { data, response, error in
        
            //мы получили дату но она закодирована. нам нужно убедиться что дата есть
            //из этой даты достать json
     //       if let data = data,
      //     let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
    }
}



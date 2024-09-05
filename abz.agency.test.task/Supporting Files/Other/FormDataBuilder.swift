import UIKit

class FormDataBuilder {
    static func createFormData(boundary: String, registrationInfo: UserRegistrationInfo, formattedPhone: String, positionId: Int?, image: UIImage?) -> Data {
        var body = Data()
        
        body.append(convertFormField(name: "name", value: registrationInfo.name, using: boundary))
        body.append(convertFormField(name: "email", value: registrationInfo.email, using: boundary))
        body.append(convertFormField(name: "phone", value: formattedPhone, using: boundary))
        
        if let positionId = positionId {
            body.append(convertFormField(name: "position_id", value: String(positionId), using: boundary))
        }
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 0.7) {
            body.append(convertFileData(fieldName: "photo", fileName: "profile.jpg", mimeType: "image/jpeg", fileData: imageData, using: boundary))
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    private static func convertFormField(name: String, value: String, using boundary: String) -> Data {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
        fieldString += "\(value)\r\n"
        return Data(fieldString.utf8)
    }
    
    private static func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        var fieldData = "--\(boundary)\r\n"
        fieldData += "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n"
        fieldData += "Content-Type: \(mimeType)\r\n\r\n"
        var data = Data(fieldData.utf8)
        data.append(fileData)
        data.append("\r\n".data(using: .utf8)!)
        return data
    }
}

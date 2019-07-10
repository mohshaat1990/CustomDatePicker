# CustomDatePicker
CustomDatePicker is Swift project To Custom Data Picker 


![ezgif com-video-to-gif-3](https://user-images.githubusercontent.com/11280137/60896019-e3dfc380-a265-11e9-8bb0-97e8466ad0d8.gif)


using pods

```bash
pod 'CustomDatePickerLib' 
```


## Usage

```swift
let customDatePicker = CustomDatePicker.loadNib()
customDatePicker.datePickerFormatt = .month
customDatePicker.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 300)
customDatePicker.delegate = self
self.view.addSubview(customDatePicker)
customDatePicker.setupDatePickerView()
customDatePicker.animateShow()
```
## you must implement delegate

```swift
extension ViewController: DatePickerDelegate {
func cancelDialog() {
customDatePicker.animateHide()
}

func selecteDate(from: Int, to: Int, dateString: String) {
dateSelectedLabel.text = dateString
}

}
```

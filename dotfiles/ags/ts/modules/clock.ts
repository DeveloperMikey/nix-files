const time = Variable('', {
	poll: [1000, 'date +"%H:%M"']
})

const CalendarBarButton = () => Widget.Button({
	class_name: 'calendar-button bar-content',
  label: time.bind(),
});


export {time, CalendarBarButton}

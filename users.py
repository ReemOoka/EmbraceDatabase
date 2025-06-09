from tkinter import *
from tkinter import ttk
import mysql.connector
import tkinter.messagebox
from PIL import ImageTk, Image
import os
from dotenv import load_dotenv
load_dotenv()

# Establishing a connection with the database
conn = mysql.connector.connect(host=os.getenv('DB_HOST'), user=os.getenv('DB_USER'), password=os.getenv('DB_PASSWORD'), database='warehouse_management')
mycursor = conn.cursor()

class Users():
    """This class is to perform operations on the Users table of our database"""
    def __init__(self, window):
        self.window = window
        self.left = Frame(window, width=2000, height=1600, bg="white")
        self.left.pack(side=LEFT)

        self.right = Frame(window, width=10, height=1600, bg="white")
        self.right.pack(side=RIGHT)

        self.back_img = Image.open('images/users_in1.png')  # Assuming you have an image for users
        self.back_img = self.back_img.resize((700, 450), Image.ANTIALIAS)
        self.back_img1 = ImageTk.PhotoImage(self.back_img)
        self.background_label = Label(self.left, image=self.back_img1, compound="right", bg="white", fg=None)
        self.background_label.pack(side="top", fill="both")
        self.background_label.place(x=150, y=-350, relwidth=1, relheight=1)

        self.heading = Label(self.left, text="User Details", font=('arial 30 bold'), fg='HotPink4', bg="white")
        self.heading.place(x=200, y=0)

        self.heading = Label(self.left, text="User ID", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=100)

        self.heading = Label(self.left, text="Username", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=140)

        self.heading = Label(self.left, text="Password", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=180)

        self.heading = Label(self.left, text="First Name", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=220)

        self.heading = Label(self.left, text="Last Name", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=260)

        self.heading = Label(self.left, text="Email", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=300)

        self.heading = Label(self.left, text="Is Admin", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=340)

        # Entries for all Labels
        self.user_id = Entry(self.left, width=30, bg="ghost white")
        self.user_id.place(x=210, y=100)

        self.username = Entry(self.left, width=30, bg="ghost white")
        self.username.place(x=210, y=140)

        self.password = Entry(self.left, width=30, bg="ghost white", show="*")
        self.password.place(x=210, y=180)

        self.FN = Entry(self.left, width=30, bg="ghost white")
        self.FN.place(x=210, y=220)

        self.LN = Entry(self.left, width=30, bg="ghost white")
        self.LN.place(x=210, y=260)

        self.email = Entry(self.left, width=30, bg="ghost white")
        self.email.place(x=210, y=300)

        self.is_admin = Entry(self.left, width=30, bg="ghost white")
        self.is_admin.place(x=210, y=340)

        # Submit Button
        self.submit = Button(self.left, text="Add User", width=15, height=2, font=('arial 10 bold'), bg="MistyRose3", fg='dark slate blue', command=self.add_user)
        self.submit.place(x=100, y=400)

        # Search Button
        self.search = Button(self.left, text="Click to search", width=15, height=2, font=('arial 10 bold'), bg="MistyRose3", fg='dark slate blue', command=self.searchUser)
        self.search.place(x=250, y=400)

        self.exit_now = Button(self.left, text="Close", width=15, height=2, font=('arial 10 bold'), bg="MistyRose3", fg='dark slate blue', command=self.window.destroy)
        self.exit_now.place(x=390, y=400)

        self.clear_now2 = Button(self.left, text="Clear", width=15, height=2, font=('arial 10 bold'), bg="MistyRose3", fg='dark slate blue', command=self.clear2)
        self.clear_now2.place(x=550, y=400)

    def add_user(self):
        """This function is used to add a new user into the Users table of our Warehouse Management system"""
        self.val1 = self.user_id.get()
        self.val2 = self.username.get()
        self.val3 = self.password.get()
        self.val4 = self.FN.get()
        self.val5 = self.LN.get()
        self.val6 = self.email.get()
        self.val7 = self.is_admin.get()

        if self.val1 == '' or self.val2 == '' or self.val3 == '' or self.val4 == '' or self.val5 == '' or self.val6 == '' or self.val7 == '':
            tkinter.messagebox.showinfo("Error", "Fill in all fields")
        else:
            query_loc = "INSERT INTO Users(userID, username, password, Fname, Lname, email, isAdmin) VALUES(%s, %s, %s, %s, %s, %s, %s)"
            values = (self.val1, self.val2, self.val3, self.val4, self.val5, self.val6, self.val7)
            mycursor.execute(query_loc, values)
            conn.commit()
            self.clear2()
            tkinter.messagebox.showinfo("Success", "Successfully added", parent=self.left)

    def searchUser(self):
        """This function opens a new window when the user clicks on the search button in the main window. It provides other options like edit as well."""
        self.search_user = Tk()
        self.search_user.title("Search User")
        self.search_user.geometry("1600x1000")
        self.drop = ttk.Combobox(self.search_user, value=["User ID", "Username", "Email", "Is Admin"])
        self.drop.current(1)
        self.drop.place(x=0, y=50)
        self.search_box = Entry(self.search_user)
        self.search_box.place(x=150, y=50)

        # Search button
        self.search_now = Button(self.search_user, text="Search User", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.searchNow)
        self.search_now.place(x=100, y=100)

        # Close button
        self.exit_now = Button(self.search_user, text="Close", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.search_user.destroy)
        self.exit_now.place(x=250, y=100)

        # Edit button
        self.edit_now = Button(self.search_user, text="Change", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.editNow)
        self.edit_now.place(x=400, y=100)

        # Clear Button
        self.clear_now = Button(self.search_user, text="Clear", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.clear)
        self.clear_now.place(x=550, y=100)

    def searchNow(self):
        """This function helps us to search for any data in Users table"""
        selected = self.drop.get()
        if selected == "User ID":
            sql_query = "SELECT * FROM Users WHERE userID=%s"
        elif selected == "Username":
            sql_query = "SELECT * FROM Users WHERE username=%s"
        elif selected == "Email":
            sql_query = "SELECT * FROM Users WHERE email=%s"
        elif selected == "Is Admin":
            sql_query = "SELECT * FROM Users WHERE isAdmin=%s"

        searched = self.search_box.get()
        name = (searched,)
        mycursor.execute(sql_query, name)
        searchResult = mycursor.fetchall()
        cols = ('User ID', 'Username', 'Password', 'First Name', 'Last Name', 'Email', 'Is Admin')
        self.listBox = ttk.Treeview(self.search_user, columns=cols, show='headings')
        # set column headings
        for col in cols:
            self.listBox.heading(col, text=col)
        for i, (userID, username, password, Fname, Lname, email, isAdmin) in enumerate(searchResult, start=1):
            self.listBox.insert("", "end", values=(i, userID, username, password, Fname, Lname, email, isAdmin))
        self.listBox.place(x=0, y=200)
        if searchResult:
            id = self.listBox.focus()
            self.id_item = self.listBox.item(id)

        self.listBox.bind("<<TreeviewSelect>>", self.onSelect)

        if not searchResult:
            searchResult = "User not found"
            searched_label = Label(self.search_user, text=searchResult)
            searched_label.place(x=0, y=160)

    def editNow(self):
        """This function is called when we click on the change button. We need to select the user and then click on the edit button.
        This function then provides us the option to update or delete"""
        try:
            if self.item_text:
                self.luser_Id = Label(self.search_user, text="User ID", font=('arial 10 bold'), fg='black')
                self.luser_Id.place(x=0, y=450)

                self.user_Id2 = Entry(self.search_user, width=30)
                self.user_Id2.place(x=210, y=450)
                self.user_Id2.insert(0, self.item_text[1])
                self.user_Id2.config(state=DISABLED)

                self.lusername = Label(self.search_user, text="Username", font=('arial 10 bold'), fg='black')
                self.lusername.place(x=0, y=480)

                self.username2 = Entry(self.search_user, width=30)
                self.username2.place(x=210, y=480)
                self.username2.insert(0, self.item_text[2])

                self.lpassword = Label(self.search_user, text="Password", font=('arial 10 bold'), fg='black')
                self.lpassword.place(x=0, y=510)

                self.password2 = Entry(self.search_user, width=30)
                self.password2.place(x=210, y=510)
                self.password2.insert(0, self.item_text[3])

                self.lFN = Label(self.search_user, text="First Name", font=('arial 10 bold'), fg='black')
                self.lFN.place(x=0, y=540)

                self.FN2 = Entry(self.search_user, width=30)
                self.FN2.place(x=210, y=540)
                self.FN2.insert(0, self.item_text[4])

                self.lLN = Label(self.search_user, text="Last Name", font=('arial 10 bold'), fg='black')
                self.lLN.place(x=0, y=570)

                self.LN2 = Entry(self.search_user, width=30)
                self.LN2.place(x=210, y=570)
                self.LN2.insert(0, self.item_text[5])

                self.lemail = Label(self.search_user, text="Email", font=('arial 10 bold'), fg='black')
                self.lemail.place(x=0, y=600)

                self.email2 = Entry(self.search_user, width=30)
                self.email2.place(x=210, y=600)
                self.email2.insert(0, self.item_text[6])

                self.lis_admin = Label(self.search_user, text="Is Admin", font=('arial 10 bold'), fg='black')
                self.lis_admin.place(x=0, y=630)

                self.is_admin2 = Entry(self.search_user, width=30)
                self.is_admin2.place(x=210, y=630)
                self.is_admin2.insert(0, self.item_text[7])

                self.update_now = Button(self.search_user, text="Update", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.updateNow)
                self.update_now.place(x=70, y=690)

                self.delete_now = Button(self.search_user, text="Delete", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.deleteNow)
                self.delete_now.place(x=180, y=690)

        except:
            tkinter.messagebox.showinfo("Warning", "Please select a user to edit", parent=self.search_user)

    def onSelect(self, val):
        """This function is called when we select a user from the search results"""
        sender = val.widget
        self.item_text = sender.item(sender.selection())['values']

    def updateNow(self):
        """This function is called when we click on the update button. It updates the user details in the Users table"""
        self.val1 = self.user_Id2.get()
        self.val2 = self.username2.get()
        self.val3 = self.password2.get()
        self.val4 = self.FN2.get()
        self.val5 = self.LN2.get()
        self.val6 = self.email2.get()
        self.val7 = self.is_admin2.get()

        query_loc = "UPDATE Users SET username=%s, password=%s, Fname=%s, Lname=%s, email=%s, isAdmin=%s WHERE userID=%s"
        values = (self.val2, self.val3, self.val4, self.val5, self.val6, self.val7, self.val1)
        mycursor.execute(query_loc, values)
        conn.commit()
        tkinter.messagebox.showinfo("Success", "Successfully updated", parent=self.search_user)
        self.clear()

    def deleteNow(self):
        """This function is called when we click on the delete button. It deletes the user from the Users table"""
        self.val1 = self.user_Id2.get()
        query_loc = "DELETE FROM Users WHERE userID=%s"
        values = (self.val1,)
        mycursor.execute(query_loc, values)
        conn.commit()
        tkinter.messagebox.showinfo("Success", "Successfully deleted", parent=self.search_user)
        self.clear()
    
    def clear(self):
        """This function clears the search window"""
        self.search_user.destroy()
        self.searchUser()

    def clear2(self):
        """This function clears the add user window"""
        self.user_id.delete(0, END)
        self.username.delete(0, END)
        self.password.delete(0, END)
        self.FN.delete(0, END)
        self.LN.delete(0, END)
        self.email.delete(0, END)
        self.is_admin.delete(0, END)

#root = Tk()
#root.title("Warehouse Management")
#Users(root)
#root.geometry("1600x1600+0+0")
#root.mainloop()    
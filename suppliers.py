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

class Suppliers():
    """This class is to perform operations on the Suppliers table of our database"""
    def __init__(self, window):
        self.window = window
        self.left = Frame(window, width=2000, height=1600, bg="white")
        self.left.pack(side=LEFT)

        self.right = Frame(window, width=10, height=1600, bg="white")
        self.right.pack(side=RIGHT)

        # Updated background image path
        self.back_img = Image.open('images/suppliers_in2.png')
        self.back_img = self.back_img.resize((700, 450), Image.ANTIALIAS)
        self.back_img1 = ImageTk.PhotoImage(self.back_img)
        self.background_label = Label(self.left, image=self.back_img1, compound="right", bg="white", fg=None)
        self.background_label.pack(side="top", fill="both")
        self.background_label.place(x=250, y=-280, relwidth=1, relheight=1)

        self.heading = Label(self.left, text="Store's Suppliers Information", font=('arial 30 bold'), fg='HotPink4', bg="white")
        self.heading.place(x=200, y=0)

        # Updated labels for table columns
        self.heading = Label(self.left, text="SupplierID", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=100)

        self.heading = Label(self.left, text="SupplierName", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=140)

        self.heading = Label(self.left, text="SupplierAddress", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=180)

        self.heading = Label(self.left, text="SupplierPhoneNumber", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=220)

        self.heading = Label(self.left, text="SupplierEmail", font=('arial 10 bold'), fg='black', bg="white")
        self.heading.place(x=0, y=260)

        # Entries for all Labels
        self.Supplier_No = Entry(self.left, width=30, bg="ghost white")
        self.Supplier_No.place(x=210, y=100)

        self.Supplier_Name = Entry(self.left, width=30, bg="ghost white")
        self.Supplier_Name.place(x=210, y=140)

        self.Supplier_Address = Entry(self.left, width=30, bg="ghost white")
        self.Supplier_Address.place(x=210, y=180)

        self.Mobile = Entry(self.left, width=30, bg="ghost white")
        self.Mobile.place(x=210, y=220)

        self.Email = Entry(self.left, width=30, bg="ghost white")
        self.Email.place(x=210, y=260)

        # Submit Button
        self.submit = Button(self.left, text="Add Supplier", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.add_Supplier)
        self.submit.place(x=100, y=400)

        # Search Button
        self.search = Button(self.left, text="Click to search", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.searchSupplier)
        self.search.place(x=250, y=400)

        self.exit_now = Button(self.left, text="Close", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.window.destroy)
        self.exit_now.place(x=390, y=400)

        self.clear_now2 = Button(self.left, text="Clear", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.clear2)
        self.clear_now2.place(x=550, y=400)

    def add_Supplier(self):
        """This function is used add a new Supplier into the Suppliers table of our Grocery Store Management system"""
        self.val1 = self.Supplier_No.get()
        self.val2 = self.Supplier_Name.get()
        self.val3 = self.Supplier_Address.get()
        self.val4 = self.Mobile.get()
        self.val5 = self.Email.get()

        if self.val1 == '' or self.val2 == '' or self.val3 == '' or self.val4 == '' or self.val5 == '':
            tkinter.messagebox.showinfo("Error", "Fill in all fields")
        else:
            query_loc = "INSERT INTO Suppliers(supplierID, supplierName, supplierAddress, supplierPhoneNumber, supplierEmail) VALUES (%s, %s, %s, %s, %s)"
            values = (self.val1, self.val2, self.val3, self.val4, self.val5)
            mycursor.execute(query_loc, values)
            conn.commit()
            self.clear2()
            tkinter.messagebox.showinfo("Success", "Successfully added", parent=self.left)

    def searchSupplier(self):
        """This function opens a new window when the user clicks on the search button in the main window. It provides other options like edit as well."""
        self.search_Supplier = Tk()
        self.search_Supplier.title("Search Supplier")
        self.search_Supplier.geometry("1600x1000")
        self.drop = ttk.Combobox(self.search_Supplier, value=["supplierID", "supplierName", "supplierPhoneNumber", "supplierEmail"])
        self.drop.current(0)
        self.drop.place(x=0, y=50)

        self.search_box = Entry(self.search_Supplier)
        self.search_box.place(x=150, y=50)

        # Search button
        self.search_now = Button(self.search_Supplier, text="Search Supplier", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.searchNow)
        self.search_now.place(x=100, y=100)

        # Close button
        self.exit_now = Button(self.search_Supplier, text="Close", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.search_Supplier.destroy)
        self.exit_now.place(x=250, y=100)

        # Edit button
        self.edit_now = Button(self.search_Supplier, text="Change", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.editNow)
        self.edit_now.place(x=400, y=100)

        # Clear Button
        self.clear_now = Button(self.search_Supplier, text="Clear", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.clear)
        self.clear_now.place(x=550, y=100)

    def searchNow(self):
        """This function helps us to search for any data in the Supplier table"""
        selected = self.drop.get()
        if selected == "supplierID":
            sql_query = "SELECT * FROM Suppliers WHERE supplierID=%s"
        elif selected == "supplierName":
            sql_query = "SELECT * FROM Suppliers WHERE supplierName=%s"
        elif selected == "supplierAddress":
            sql_query = "SELECT * FROM Suppliers WHERE supplierAddress=%s"
        elif selected == "supplierPhoneNumber":
            sql_query = "SELECT * FROM Suppliers WHERE supplierPhoneNumber=%s"
        elif selected == "supplierEmail":
            sql_query = "SELECT * FROM Suppliers WHERE supplierEmail=%s"

        searched = self.search_box.get()
        name = (searched,)
        mycursor.execute(sql_query, name)
        searchResult = mycursor.fetchall()
        print(searchResult)

        cols = ('SupplierID', 'SupplierName', 'supplierAddress', 'supplierPhoneNumber', 'supplierEmail')
        self.listBox = ttk.Treeview(self.search_Supplier, columns=cols, show='headings')

        # set column headings
        for col in cols:
            self.listBox.heading(col, text=col)

        for i, (supplierID, supplierName, supplierAddress, supplierPhoneNumber, supplierEmail) in enumerate(searchResult, start=1):
            self.listBox.insert("", "end", values=(i, supplierID, supplierName, supplierAddress, supplierPhoneNumber, supplierEmail))
        self.listBox.place(x=0, y=200)

        if searchResult:
            id = self.listBox.focus()
            self.id_item = self.listBox.item(id)
        self.listBox.bind("<<TreeviewSelect>>", self.onSelect)
        if not searchResult:
            searchResult = "Supplier not found"
            searched_label = Label(self.search_Supplier, text=searchResult)
            searched_label.place(x=0, y=160)

    def editNow(self):
        """This function is called when we click on the change button. We need to select the supplier and then click on the edit button.
        This function then provides us the option to update or delete"""
        try:
            if self.item_text:
                self.lsup_no = Label(self.search_Supplier, text="SupplierID", font=('arial 10 bold'), fg='black')
                self.lsup_no.place(x=0, y=450)

                self.sup_no = Entry(self.search_Supplier, width=30)
                self.sup_no.place(x=210, y=450)
                self.sup_no.insert(0, self.item_text[1])
                self.sup_no.config(state=DISABLED)

                self.lsup_name = Label(self.search_Supplier, text="SupplierName", font=('arial 10 bold'), fg='black')
                self.lsup_name.place(x=0, y=480)

                self.sup_name = Entry(self.search_Supplier, width=30)
                self.sup_name.place(x=210, y=480)
                self.sup_name.insert(0, self.item_text[2])

                self.lmob = Label(self.search_Supplier, text="SupplierPhoneNumber", font=('arial 10 bold'), fg='black')
                self.lmob.place(x=0, y=510)
                self.mob = Entry(self.search_Supplier, width=30)
                self.mob.place(x=210, y=510)
                self.mob.insert(0, self.item_text[3])

                self.lloc_id = Label(self.search_Supplier, text="SupplierAddress", font=('arial 10 bold'), fg='black')
                self.lloc_id.place(x=0, y=540)
                self.loc_id = Entry(self.search_Supplier, width=30)
                self.loc_id.place(x=210, y=540)
                self.loc_id.insert(0, self.item_text[4])

                self.update_now = Button(self.search_Supplier, text="Update", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.updateNow)
                self.update_now.place(x=70, y=690)

                self.delete_now = Button(self.search_Supplier, text="Delete", width=15, height=2, font=('arial 10 bold'), bg="light gray", command=self.deleteNow)
                self.delete_now.place(x=180, y=690)

        except:
            tkinter.messagebox.showinfo("Warning", "Please select a Supplier to edit", parent=self.search_Supplier)

    def onSelect(self, event):
        """This function is used to get the selected item from the displayed list"""
        for item in self.listBox.selection():
            self.item_text = self.listBox.item(item, "values")

    def updateNow(self):
        """Used to update the Suppliers table"""
        update_query = "UPDATE Suppliers SET supplierName = %s, supplierPhoneNumber = %s, supplierAddress = %s, supplierEmail = %s WHERE supplierID = %s"

        SNO = self.sup_no.get()
        SNAME = self.sup_name.get()
        MOBIL = self.mob.get()
        LOC = self.loc_id.get()

        inputs = (SNAME, MOBIL, LOC, SNO)
        mycursor.execute(update_query, inputs)
        conn.commit()
        self.clear()
        tkinter.messagebox.showinfo("Success", "Successfully Updated", parent=self.search_Supplier)

    def deleteNow(self):
        """Used to delete data from Suppliers table only if there are no Suppliers working in a location"""
        supplier = self.sup_no.get()

        my_var = tkinter.messagebox.askyesnocancel("Delete ?", "Delete id:" + str(supplier), icon='warning', default='no', parent=self.search_Supplier)
        try:
            if my_var:  # True if the yes button is clicked
                mycursor.execute("DELETE FROM Suppliers WHERE supplierID= " + supplier)
                conn.commit()
                self.clear()
                tkinter.messagebox.showinfo("Success", "Successfully Deleted", parent=self.search_Supplier)
        except:
            tkinter.messagebox.showinfo("Warning", "Supplier is still present", parent=self.search_Supplier)

    def clear(self):
        """Refresh the search Suppliers window"""
        self.search_Supplier.destroy()
        self.searchSupplier()

    def clear2(self):
        """Refresh the main window"""
        self.left.destroy()
        self.right.destroy()
        self.__init__(self.window)

# root = Tk()
# root.title("Supplier Details")
# b = Suppliers(root)
# root.geometry("1200x1200+0+0")
# root.mainloop()
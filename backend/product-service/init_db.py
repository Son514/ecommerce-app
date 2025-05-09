from app import db, create_app, Product
app = create_app()
with app.app_context():
    db.create_all()
    if not Product.query.first():
        products = [
            Product(name='Laptop', price=999.99),
            Product(name='Phone', price=499.99),
            Product(name='Headphones', price=79.99)
        ]
        db.session.bulk_save_objects(products)
        db.session.commit()
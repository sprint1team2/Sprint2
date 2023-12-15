// Delete when database is complete.

const users = [
    {
        id: 1,
        username: 'user1',
        password: 'password1',
        email: 'pW9Zj@example.com'
    },
    {
        id: 2,
        username: 'user2',
        password: 'password2',
        email: 'aVwDm@example.com'
    }
];

const getAllUsers = () => {
    return users;
};

const addUser = (newUser) => {
    users.push(newUser);
};

module.exports = {
    getAllUsers,
    addUser,
};
from pyswip import Prolog
from tkinter import *

class StealthGame():
    def __init__(self):
        self.prolog = Prolog()
        self.prolog.consult('movement.pl')

        self.position = 'STAND'
        self.x = 0
        self.y = 0

        self.size_of_board = 600
        self.number_of_fields = 20
        self.stand_color = '#7BC043'
        self.crawl_color = '#556B2F'
        self.dot_width = 0.25*self.size_of_board / (self.number_of_fields+1)
        self.distance_between_dots = self.size_of_board / (self.number_of_fields+1)
        
        self.create_canvas()
        self.create_controls()
        self.create_board()
        self.draw_player()

    # ----------------------------
    # GUI
    # ----------------------------

    def create_canvas(self):
        self.window = Tk()
        self.window.title('Stealth Game')
        self.canvas = Canvas(self.window, width=self.size_of_board, height=self.size_of_board)
        self.canvas.pack()

    def create_controls(self):
        self.button_text = StringVar()
        self.button_text.set('CRAWL')
        self.button = Button(self.window, textvariable=self.button_text, fg="green", height=1, width=30, command=self.change_position)
        self.button.pack(side=LEFT, padx=20,pady=20)
        self.window.bind("<Key>", self.key_input)

    def key_input(self, event):
        key_pressed = event.keysym
        if self.check_if_key_valid(key_pressed):
            self.move(key_pressed)
            
    def check_if_key_valid(self, key):
        valid_keys = ["Up", "Down", "Left", "Right"]
        if key in valid_keys:
            return True
        else:
            return False

    def create_board(self):
        for i in range(self.number_of_fields+1):
            x = i*self.distance_between_dots+self.distance_between_dots/2
            self.canvas.create_line(x, self.distance_between_dots/2, x,
                                    self.size_of_board-self.distance_between_dots/2,
                                    fill='gray', dash = (2, 2))
            self.canvas.create_line(self.distance_between_dots/2, x,
                                    self.size_of_board-self.distance_between_dots/2, x,
                                    fill='gray', dash=(2, 2))

    def draw_player(self):
        if self.position == 'CRAWL':
            color = self.crawl_color
        else:
            color = self.stand_color
        start_x = self.x*self.distance_between_dots+self.distance_between_dots
        end_x = (self.number_of_fields - self.y - 1)*self.distance_between_dots+self.distance_between_dots
        self.player_oval = self.canvas.create_oval(start_x-self.dot_width/2, end_x-self.dot_width/2, start_x+self.dot_width/2,
                                end_x+self.dot_width/2, fill=color,
                                outline=color, dash=(2, 2))

    # ----------------------------
    # Prolog queries
    # ----------------------------

    def get_query_for_direction(self, direction):
        return 'step_' + direction.lower()

    def get_query_for_position(self, position):
        return 'make_' + position.lower()

    def move(self, direction):
        walk_dir = list(self.prolog.query(self.get_query_for_direction(direction)))
        if len(walk_dir) == 0:
            print('Can\'t walk in this direction')
            # moze bez return i jak chce isc w zlym kierunku to wysylamy do prologa 
            # return
        for position in self.prolog.query('position(player, X, Y).'):
            self.x = position['X']
            self.y = position['Y']
            self.canvas.delete(self.player_oval)
            self.draw_player()

    def change_position(self):
        if self.position == 'CRAWL':
            self.button_text.set('CRAWL')
            self.position = 'STAND'
        else:
            self.button_text.set('STAND')
            self.position = 'CRAWL'
        list(self.prolog.query(self.get_query_for_position(self.position)))
        '''
        crawls = list(self.prolog.query('crawls(player).'))
        if len(crawls) == 0:
            print('Player is standing')
        '''
        self.canvas.delete(self.player_oval)
        self.draw_player()


if __name__ == '__main__':
    game = StealthGame()
    game.window.mainloop()


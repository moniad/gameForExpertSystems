from tkinter import *

from pyswip import Prolog


class StealthGame:
    def __init__(self):
        self.prolog = Prolog()
        self.prolog.consult('opponentsStates.pl')
        self.prolog.consult('opponentsFieldOfView.pl')
        self.prolog.consult('gameEngine.pl')
        self.prolog.consult('movement.pl')
        self.prolog.consult('opponentsMotionPattern.pl')

        self.size_of_board = 600
        self.number_of_fields = 30
        self.stand_color = '#7BC043'
        self.crawl_color = '#556B2F'
        self.opponent_color = '#EE4035'
        self.view_color = "#EEE235"
        self.dot_width = 0.25 * self.size_of_board / (self.number_of_fields + 1)
        self.distance_between_dots = self.size_of_board / (self.number_of_fields + 1)

        self.start_game()

    # ----------------------------
    # GUI
    # ----------------------------

    def restart_game(self):
        self.window.destroy()

        list(self.prolog.query('retractall(position(_, _, _)).'))
        list(self.prolog.query('retractall(players_movement_counter(_)).'))
        list(self.prolog.query('retractall(players_crawling_counter(_)).'))
        list(self.prolog.query('retractall(crawling_forbidden(_)).'))
        list(self.prolog.query('retractall(crawls(_)).'))
        self.prolog.consult('movement.pl')
        
        list(self.prolog.query('retractall(opponent_looks(_)).'))
        list(self.prolog.query('retractall(opponents_movement_counter(_)).'))
        self.prolog.consult('opponentsMotionPattern.pl')

        self.start_game()
        
    def start_game(self):
        self.finish = False
        self.position = 'STAND'
        self.x = 0
        self.y = 0
        self.opponent_x = 8
        self.opponent_y = 8
        self.view_rectangles = []
        self.view_coordinates = []

        self.create_canvas()
        self.create_controls()
        self.create_board()
        self.draw_player()
        self.draw_opponent()
        self.update_opponent_view()
        self.display_crawl_text()
        self.window.mainloop()

    def create_canvas(self):
        self.window = Tk()
        self.window.title('Stealth Game')
        self.canvas = Canvas(self.window, width=self.size_of_board, height=self.size_of_board)
        self.canvas.pack()

    def create_controls(self):
        self.button_text = StringVar()
        self.button_text.set('CRAWL')
        self.button = Button(self.window, textvariable=self.button_text, fg="green", height=1, width=30,
                             command=self.change_position)
        self.button.pack(side=LEFT, padx=20, pady=20)
        self.window.bind("<Key>", self.key_input)

    def key_input(self, event):
        key_pressed = event.keysym
        if self.finish == False and self.check_if_key_valid(key_pressed):
            self.move(key_pressed)

    def check_if_key_valid(self, key):
        valid_keys = ["Up", "Down", "Left", "Right"]
        if key in valid_keys:
            return True
        else:
            return False

    def create_board(self):
        for i in range(self.number_of_fields + 1):
            x = i * self.distance_between_dots + self.distance_between_dots / 2
            self.canvas.create_line(x, self.distance_between_dots / 2, x,
                                    self.size_of_board - self.distance_between_dots / 2,
                                    fill='gray', dash=(2, 2))
            self.canvas.create_line(self.distance_between_dots / 2, x,
                                    self.size_of_board - self.distance_between_dots / 2, x,
                                    fill='gray', dash=(2, 2))

    def draw_player(self):
        if self.position == 'CRAWL':
            color = self.crawl_color
        else:
            color = self.stand_color
        start_x = self.x * self.distance_between_dots + self.distance_between_dots
        end_x = (self.number_of_fields - self.y - 1) * self.distance_between_dots + self.distance_between_dots
        self.player_oval = self.canvas.create_oval(start_x - self.dot_width / 2, end_x - self.dot_width / 2,
                                                   start_x + self.dot_width / 2,
                                                   end_x + self.dot_width / 2, fill=color,
                                                   outline=color, dash=(2, 2))

    def draw_opponent(self):
        color = self.opponent_color
        start_x = self.opponent_x * self.distance_between_dots + self.distance_between_dots
        end_x = (self.number_of_fields - self.opponent_y - 1) * self.distance_between_dots + self.distance_between_dots
        self.opponent_oval = self.canvas.create_oval(start_x - self.dot_width / 2, end_x - self.dot_width / 2,
                                                   start_x + self.dot_width / 2,
                                                   end_x + self.dot_width / 2, fill=color,
                                                   outline=color, dash=(2, 2))

    def draw_view(self):
        color = self.view_color
        for x, y in self.view_coordinates:
            if len(list(self.prolog.query(f'field_on_board({x}, {y})'))) == 0:
                continue
            x1 = x * self.distance_between_dots + self.distance_between_dots - 2 * self.dot_width
            y1 = (self.number_of_fields - y - 1) * self.distance_between_dots + self.distance_between_dots - 2 * self.dot_width
            x2 = x1 + self.distance_between_dots
            y2 = y1 + self.distance_between_dots
            self.view_rectangles.append(self.canvas.create_rectangle(x1, y1, x2, y2, fill=color, outline=''))

    def erase_view_rectangles(self):
        for rectangle in self.view_rectangles:
            self.canvas.delete(rectangle)

    def display_crawl_text(self):
        self.crawl_counter_txt = StringVar()
        self.crawl_counter_txt.set('CRAWL COUNTER: 0')
        self.crawl_counter = Label(self.window, height=2, width=40, font="cmr 10 bold", textvariable=self.crawl_counter_txt)
        self.crawl_counter.pack(side=LEFT, padx=20, pady=20)

    def display_gameover(self, win):
        self.finish = True
        self.canvas.delete("all")
        self.button.pack_forget()
        self.crawl_counter.pack_forget()

        if win:
            self.canvas.create_text(self.size_of_board / 2, self.size_of_board / 3, font="cmr 60 bold", fill=self.stand_color, text="You won")
        else:
            self.canvas.create_text(self.size_of_board / 2, self.size_of_board / 3, font="cmr 60 bold", fill=self.opponent_color, text="You lost")

        score_text = 'Click to play again \n'
        self.canvas.create_text(self.size_of_board / 2, 15 * self.size_of_board / 16, font="cmr 20 bold", fill="gray", text=score_text)
        self.play_again_btn = Button(self.window, text="Play again", fg="red", height=2, width=30, command=self.restart_game)
        self.play_again_btn.pack(padx=20, pady=20)

    # ----------------------------
    # Prolog queries
    # ----------------------------

    def get_query_for_direction(self, direction):
        return 'move_player_' + direction.lower()

    def get_query_for_position(self, position):
        return 'make_' + position.lower()

    def move(self, direction):
        walk_dir = list(self.prolog.query(self.get_query_for_direction(direction)))
        if len(walk_dir) == 0:
            print('Can\'t walk in this direction')
            # moze bez return i jak chce isc w zlym kierunku to wysylamy do prologa
            # return
        for position in self.prolog.query('position(player, X, Y)'):
            self.x = position['X']
            self.y = position['Y']
            self.canvas.delete(self.player_oval)
            self.draw_player()
        for crawl in list(self.prolog.query('players_crawling_counter(X)')):
            crawl_counter = crawl['X']
            self.crawl_counter_txt.set(f'CRAWL COUNTER: {crawl_counter}')
            if self.position =='CRAWL' and crawl_counter == 4:
                self.change_position()

        self.check_game_state()

    def check_game_state(self):
        game_over = list(self.prolog.query('game_over.'))
        if len(game_over) != 0:
            win = len(list(self.prolog.query('wins(player)'))) != 0
            #print('Loss/Win')
            self.display_gameover(win)
        else:
            self.canvas.delete(self.opponent_oval)
            self.update_opponent_position()
            self.erase_view_rectangles()
            self.update_opponent_view()
        
    def update_opponent_position(self):
        for position in self.prolog.query('position(opponent, X, Y)'):
            self.opponent_x = position['X']
            self.opponent_y = position['Y']
        self.draw_opponent()

    def update_opponent_view(self):
        self.view_coordinates.clear()
        for soln in self.prolog.query('opponent_looks(Direction)'):
            dir = soln['Direction']
            if dir == 'right' or dir == 'left':
                right = 1 if dir == 'right' else -1
                [self.view_coordinates.append((self.opponent_x + i*(right), self.opponent_y)) for i in range(1, 6)]
                [self.view_coordinates.append((self.opponent_x + i*(right), self.opponent_y + j)) for i in range(2, 6) for j in [-1, 1]]
                [self.view_coordinates.append((self.opponent_x + i*(right), self.opponent_y + j)) for i in range(3, 6) for j in [-2, 2]]
                [self.view_coordinates.append((self.opponent_x + i*(right), self.opponent_y + j)) for i in range(4, 6) for j in [-3, 3]]
                [self.view_coordinates.append((self.opponent_x + i*(right), self.opponent_y + j)) for i in range(5, 6) for j in [-4, 4]]
            if dir == 'down' or dir == 'up':
                up = 1 if dir == 'up' else -1
                [self.view_coordinates.append((self.opponent_x, self.opponent_y + i*(up))) for i in range(1, 6)]
                [self.view_coordinates.append((self.opponent_x + j, self.opponent_y + i*(up))) for i in range(2, 6) for j in [-1, 1]]
                [self.view_coordinates.append((self.opponent_x + j, self.opponent_y + i*(up))) for i in range(3, 6) for j in [-2, 2]]
                [self.view_coordinates.append((self.opponent_x + j, self.opponent_y + i*(up))) for i in range(4, 6) for j in [-3, 3]]
                [self.view_coordinates.append((self.opponent_x + j, self.opponent_y + i*(up))) for i in range(5, 6) for j in [-4, 4]]
        self.draw_view()

    def change_position(self):
        if self.position == 'CRAWL':
            self.button_text.set('CRAWL')
            self.crawl_counter_txt.set('CRAWL COUNTER: 0')
            self.position = 'STAND'
        else:
            self.button_text.set('STAND')
            self.position = 'CRAWL'
        list(self.prolog.query(self.get_query_for_position(self.position)))
        # todo: Prolog może nie pozwolić crawlować, jeśli już było 5 ruchów w kucki, musimy sprawdzać długość listy
        self.canvas.delete(self.player_oval)
        self.draw_player()


if __name__ == '__main__':
    game = StealthGame()

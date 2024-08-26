#include QMK_KEYBOARD_H

#define xxxxxxx KC_NO

#define SYM_SPC LT(SYM, KC_SPC)
#define NUM_BSPC LT(NUM, KC_BSPC)

// Left-hand home row mods
#define HM_A LGUI_T(KC_A)
#define HM_S LALT_T(KC_S)
#define HM_D LSFT_T(KC_D)
#define HM_F LCTL_T(KC_F)

// Right-hand home row mods
#define HM_J RCTL_T(KC_J)
#define HM_K RSFT_T(KC_K)
#define HM_L LALT_T(KC_L)
#define HM_SCLN RGUI_T(KC_SCLN)

enum layers {
    BASE = 0,
    NAV,
    SYM,
    NUM,
    FUN,
};

enum custom_keycodes {
    GO_ASSN = SAFE_RANGE,
    SP_TERM,

};

enum combos {
    GESC_Q__GRV,
    BSPC_RBRC__BSLS,
    NUM_BSPC_SYM_SPC__ESC,
};

const uint16_t PROGMEM gesc_q_combo[] = {QK_GESC, KC_Q, COMBO_END};
const uint16_t PROGMEM bspc_rbcrc_combo[] = {KC_BSPC, KC_RBRC, COMBO_END};
const uint16_t PROGMEM num_bspc_sym_spc_combo[] = {NUM_BSPC, SYM_SPC, COMBO_END};

combo_t key_combos[] = {
    [GESC_Q__GRV] = COMBO(gesc_q_combo, KC_GRV),
    [BSPC_RBRC__BSLS] = COMBO(bspc_rbcrc_combo, KC_BSLS),
    [NUM_BSPC_SYM_SPC__ESC] = COMBO(num_bspc_sym_spc_combo, KC_ESC),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    [BASE] = LAYOUT(
        QK_GESC, KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSPC,
        KC_TAB,  HM_A,    HM_S,    HM_D,    HM_F,    KC_G,    KC_H,    HM_J,    HM_K,    HM_L,    HM_SCLN, KC_QUOT,          KC_ENT,
        SC_LSPO,          KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, SC_RSPC, SP_TERM,
                 KC_LCTL, KC_LCMD, MO(NAV),          NUM_BSPC,xxxxxxx, SYM_SPC,          KC_NO,   KC_ROPT, MO(FUN)
    ),

    [NAV] = LAYOUT(
        _______, _______, _______, _______, _______, _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,  _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, _______, _______,          _______,
        _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
                 _______, _______, _______,          _______, xxxxxxx, _______,          _______, _______, _______
    ),

    [SYM] = LAYOUT(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, KC_EXLM, KC_MINS, KC_PLUS, KC_EQL,  KC_UNDS, _______, KC_COLN, KC_AMPR, _______, _______, _______,          _______,
        _______,          _______, KC_SLSH, KC_ASTR, GO_ASSN, _______, _______, _______, _______, _______, _______, _______, _______,
                 _______, _______, _______,          _______, xxxxxxx, _______,          _______, _______, _______
    ),

    [NUM] = LAYOUT(
        _______, KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______,
        _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
                 _______, _______, _______,          _______, xxxxxxx, _______,          _______, _______, _______
    ),

    [FUN] = LAYOUT(
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
        _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          _______,
        _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
                 _______, _______, _______,          _______, xxxxxxx, _______,          _______, _______, _______
    )

};


bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (record->event.pressed) {
        switch (keycode) {
        case GO_ASSN:
            SEND_STRING_DELAY(":=", TAP_CODE_DELAY);
            return false;
        }
    }
    return true;
};

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t* record) {
  switch (keycode) {
    // Increase the tapping term a little for slower ring and pinky fingers.
    case HM_A:
    case HM_SCLN:
      return TAPPING_TERM + 15;

    default:
      return TAPPING_TERM;
  }
};

uint16_t get_quick_tap_term(uint16_t keycode, keyrecord_t* record) {
    // If you quickly hold a tap-hold key after tapping it, the tap action is
    // repeated. Key repeating is useful e.g. for Vim navigation keys, but can
    // lead to missed triggers in fast typing. Here, returning 0 means we
    // instead want to "force hold" and disable key repeating.
    switch (keycode) {
        // Repeating is useful for Vim navigation keys.
        case HM_J:
        case HM_K:
        case HM_L:
            return QUICK_TAP_TERM;  // Enable key repeating.
        default:
            return 0;  // Otherwise, force hold and disable key repeating.
    }
};

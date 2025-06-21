(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun append/1183289509 (String Int) String)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var964 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var964 null-String)))
(declare-const var3755 (Array Int Int)) ; Statement: r1 := @parameter1: char[] 
(assert (not (= var3755 null-__Array__Int__Int__)))
(assert true)
;(assert (append/1183289509 var964 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var964!1 String)
(declare-const var1865 Int)
(define-const var3674 Int (getLength-Arr-Int-1 var3755)) ; Statement: i0 = lengthof r1 
(define-const var1187 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 
(assert (>= var1187 var3674)) ; Cond: i3 >= i0 
(assert true)
;(assert (append/1183289509 var964!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var964!2 String)
(declare-const var599 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), getLength-Arr-Int-1=([char[]], int)}
; {var964=r0, var3755=r1, var1865=91, var3674=i0, var1187=i3, var599=93}
; {r0=var964, r1=var3755, 91=var1865, i0=var3674, i3=var1187, 93=var599}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r1 := @parameter1: char[];	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3
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
(declare-fun getLength-Arr-Bool-1 ((Array Int Bool)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__Bool__ (Array Int Bool))
(declare-const var701 String) ; Statement: r0 := @parameter0: java.lang.StringBuffer 
(assert (not (= var701 null-String)))
(declare-const var2216 (Array Int Bool)) ; Statement: r1 := @parameter1: boolean[] 
(assert (not (= var2216 null-__Array__Int__Bool__)))
(assert true)
;(assert (append/1183289509 var701 91)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91) 

(declare-const var701!1 String)
(declare-const var143 Int)
(define-const var1398 Int (getLength-Arr-Bool-1 var2216)) ; Statement: i0 = lengthof r1 
(define-const var650 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 
(assert (>= var650 var1398)) ; Cond: i2 >= i0 
(assert true)
;(assert (append/1183289509 var701!1 93)) ; Statement: virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93) 

(declare-const var701!2 String)
(declare-const var812 Int)
 ; Statement: return 
(check-sat)
; {append/1183289509=([java.lang.StringBuffer, char], java.lang.StringBuffer), getLength-Arr-Bool-1=([boolean[]], int)}
; {var701=r0, var2216=r1, var143=91, var1398=i0, var650=i2, var812=93}
; {r0=var701, r1=var2216, 91=var143, i0=var1398, i2=var650, 93=var812}
;seq <java.lang.StringBuffer: java.lang.StringBuffer append(char)>;	<java.lang.StringBuffer: java.lang.StringBuffer append(char)>
;cnt {"<java.lang.StringBuffer: java.lang.StringBuffer append(char)>": 2}
;stmts r0 := @parameter0: java.lang.StringBuffer;	r1 := @parameter1: boolean[];	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(91);	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	virtualinvoke r0.<java.lang.StringBuffer: java.lang.StringBuffer append(char)>(93);	return
;block_num 3
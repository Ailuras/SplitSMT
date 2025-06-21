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
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun String-init () String)
(declare-fun <init>/-915723298 (String (Array Int Int)) void)
(declare-const null-Int Int)
(declare-const var2792 Int) ; Statement: c1 := @parameter0: char 
(assert (not (= var2792 null-Int)))
(declare-const var520 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var520 null-Int)))
(define-const var145 (Array Int Int) arr-Int-init) ; Statement: r0 = newarray (char)[i0] 
(define-const var3009 Int (- var520 1)) ; Statement: i2 = i0 - 1 
(assert true) ; Non Conditional
 ; Statement: if i2 < 0 goto $r2 = new java.lang.String 
(assert (< var3009 0)) ; Cond: i2 < 0 
(define-const var3432 String String-init) ; Statement: $r2 = new java.lang.String 
(assert true)
;(assert (<init>/-915723298 var3432 var145)) ; Statement: specialinvoke $r2.<java.lang.String: void <init>(char[])>(r0) 

(declare-const var3432!1 String)
(declare-const var145!1 (Array Int Int))
 ; Statement: return $r2 
(check-sat)
; {arr-Int-init=([], char[]), String-init=([], java.lang.String), <init>/-915723298=([java.lang.String, char[]], void)}
; {var2792=c1, var520=i0, var145=r0, var3009=i2, var3432=$r2}
; {c1=var2792, i0=var520, r0=var145, i2=var3009, $r2=var3432}
;seq <java.lang.String: void <init>(char[])>
;cnt {"<java.lang.String: void <init>(char[])>": 1}
;stmts c1 := @parameter0: char;	i0 := @parameter1: int;	r0 = newarray (char)[i0];	i2 = i0 - 1;	if i2 < 0 goto $r2 = new java.lang.String;	$r2 = new java.lang.String;	specialinvoke $r2.<java.lang.String: void <init>(char[])>(r0);	return $r2
;block_num 3
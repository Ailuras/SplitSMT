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

(declare-sort var747 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var2194 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2194 null-String)))
(assert true)
(define-const var377 String (trim/-847153721 var2194)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var22 Int (length/-134980193 var377)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var1738 Int (- var22 1)) ; Statement: i1 = $i0 - 1 
(define-const var3351 Int (cast-from-Int-to-Int -1)) ; Statement: $i4 = (int) -1 
 ; Statement: if i1 <= $i4 goto $r2 = r1 
(assert (<= var1738 var3351)) ; Cond: i1 <= $i4 
(define-const var2143 String var377) ; Statement: $r2 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), cast-from-Int-to-Int=([int], int)}
; {var2194=r0, var747=null_type, var377=r1, var22=$i0, var1738=i1, var3351=$i4, var2143=$r2}
; {r0=var2194, null_type=var747, r1=var377, $i0=var22, i1=var1738, $i4=var3351, $r2=var2143}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	i1 = $i0 - 1;	$i4 = (int) -1;	if i1 <= $i4 goto $r2 = r1;	$r2 = r1;	return $r2
;block_num 3
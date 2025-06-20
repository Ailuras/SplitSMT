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

(declare-sort var2484 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-const null-String String)
(declare-const var2145 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2145 null-String)))
(assert true)
(define-const var759 Int (length/-134980193 var2145)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 >= 1024 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, 1024) 
(assert (>= var759 1024)) ; Cond: $i0 >= 1024 
(assert (not (and true (and (>= 0 0) (>= (str.len var2145) 1024) (>= 1024 0)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String)}
; {var2145=r0, var2484=null_type, var759=$i0, var3163=$r1}
; {r0=var2145, null_type=var2484, $i0=var759, $r1=var3163}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 >= 1024 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, 1024);	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, 1024);	return $r1
;block_num 2
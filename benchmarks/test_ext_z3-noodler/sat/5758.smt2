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

(declare-sort var1010 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1652 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1652 null-String)))
(define-const var1371 (Array Int String) arr-String-init) ; Statement: r0 = newarray (java.lang.String)[3] 
(assert true)
(define-const var2681 Int (indexOf/-1037706067 var1652 47)) ; Statement: i0 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(47) 
 ; Statement: if i0 <= 0 goto $i3 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(58) 
(assert (<= var2681 0)) ; Cond: i0 <= 0 
(assert true)
(define-const var327 Int (indexOf/-1037706067 var1652 58)) ; Statement: $i3 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(58) 
 ; Statement: if $i3 <= 0 goto r0[1] = r3 
(assert (<= var327 0)) ; Cond: $i3 <= 0 
(declare-const var1371!1 (Array Int String))
(assert (not (= var1371!1 null-__Array__Int__String__)))
(assert (= (select var1371!1 1) var1652)) ; Statement: r0[1] = r3 
 ; Statement: return r0 
(check-sat)
; {arr-String-init=([], java.lang.String[]), indexOf/-1037706067=([java.lang.String, int], int)}
; {var1652=r3, var1010=null_type, var1371=r0, var2681=i0, var327=$i3}
; {r3=var1652, null_type=var1010, r0=var1371, i0=var2681, $i3=var327}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int indexOf(int)>
;cnt {"<java.lang.String: int indexOf(int)>": 2}
;stmts r3 := @parameter0: java.lang.String;	r0 = newarray (java.lang.String)[3];	i0 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(47);	if i0 <= 0 goto $i3 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(58);	$i3 = virtualinvoke r3.<java.lang.String: int indexOf(int)>(58);	if $i3 <= 0 goto r0[1] = r3;	r0[1] = r3;	return r0
;block_num 3
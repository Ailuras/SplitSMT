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

(declare-sort var1774 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3220 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3220 null-String)))
(define-const var3111 (Array Int String) arr-String-init) ; Statement: $r0 = newarray (java.lang.String)[1] 
(assert true)
(define-const var1850 Int (indexOf/-1209756239 var3220 " ")) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>(" ") 
(define-const var768 Int (+ var1850 1)) ; Statement: $i1 = $i0 + 1 
(assert (not (and true (and (>= var768 0) (>= (str.len var3220) var768)))))
(check-sat)
; {arr-String-init=([], java.lang.String[]), indexOf/-1209756239=([java.lang.String, java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var3220=r1, var1774=null_type, var3111=$r0, var1850=$i0, var768=$i1, var2687=$r2, var2080=$r3}
; {r1=var3220, null_type=var1774, $r0=var3111, $i0=var1850, $i1=var768, $r2=var2687, $r3=var2080}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = newarray (java.lang.String)[1];	$i0 = virtualinvoke r1.<java.lang.String: int indexOf(java.lang.String)>(" ");	$i1 = $i0 + 1;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>($i1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$r0[0] = $r3;	return $r0
;block_num 1
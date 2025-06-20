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

(declare-sort var1549 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var118 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var118 null-String)))
(declare-const var3717 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3717 null-Int)))
(define-const var414 (Array Int String) arr-String-init) ; Statement: r4 = newarray (java.lang.String)[2] 
(define-const var706 Int (+ var3717 3)) ; Statement: i1 = i0 + 3 
(define-const var1029 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 != $i3 goto (branch) 
(assert (not (= var3717 var1029))) ; Cond: i0 != $i3 
 ; Statement: if i0 < 0 goto $r0 = newarray (java.lang.String)[1] 
(assert (not (< var3717 0))) ; Negate: Cond: i0 < 0  
(assert (and true (and (>= 0 0) (>= (str.len var118) var3717) (>= var3717 0))))
(define-const var1975 String (substring/-1240304868 var118 0 var3717)) ; Statement: $r1 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int,int)>(0, i0) 
(declare-const var414!1 (Array Int String))
(assert (not (= var414!1 null-__Array__Int__String__)))
(assert (= (select var414!1 0) var1975)) ; Statement: r4[0] = $r1 
(assert (and true (and (>= var706 0) (>= (str.len var118) var706))))
(define-const var654 String (substring/850833817 var118 var706)) ; Statement: $r2 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>(i1) 
(declare-const var414!2 (Array Int String))
(assert (not (= var414!2 null-__Array__Int__String__)))
(assert (= (select var414!2 1) var654)) ; Statement: r4[1] = $r2 
 ; Statement: goto [?= return r4] 
(assert true) ; Non Conditional
 ; Statement: return r4 
(check-sat)
; {arr-String-init=([], java.lang.String[]), cast-from-Int-to-Int=([int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String)}
; {var118=r3, var1549=null_type, var3717=i0, var414=r4, var706=i1, var1029=$i3, var1975=$r1, var654=$r2}
; {r3=var118, null_type=var1549, i0=var3717, r4=var414, i1=var706, $i3=var1029, $r1=var1975, $r2=var654}
;seq <java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r3 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r4 = newarray (java.lang.String)[2];	i1 = i0 + 3;	$i3 = (int) -1;	if i0 != $i3 goto (branch);	if i0 < 0 goto $r0 = newarray (java.lang.String)[1];	$r1 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	r4[0] = $r1;	$r2 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>(i1);	r4[1] = $r2;	goto [?= return r4];	return r4
;block_num 4
(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1606 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1606 null-String)))
(assert (and true (and (>= 2 0) (>= (str.len var1606) 2))))
(define-const var3662 String (substring/850833817 var1606 2)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(2) 
; split operation: var1672 = var3662.split("=") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var2602 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var3874 Int (get_split_length var3662 "=" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto return r2 
(assert (not (>= var2602 var3874))) ; Negate: Cond: i1 >= $i0  
(define-const var3742 String (get_split_element var3662 "=" -1 var2602)) ; Statement: $r3 = r2[i1] 
(assert true)
(define-const var2512 String (trim/-847153721 var3742)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
(declare-const var1672!1 (Array Int String))
(assert (not (= var1672!1 null-__Array__Int__String__)))
(assert (= (select var1672!1 var2602) var2512)) ; Statement: r2[i1] = $r4 
(define-const var2602!1 Int (+ var2602 1)) ; Statement: i1 = i1 + 1 
 ; Statement: goto [?= $i0 = lengthof r2] 
(assert true) ; Non Conditional
(define-const var3874!1 Int (getLength-Arr-String-1 var1672!1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto return r2 
(assert (>= var2602!1 var3874!1)) ; Cond: i1 >= $i0 
 ; Statement: return r2 
(check-sat)
; {substring/850833817=([java.lang.String, int], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), getLength-Arr-String-1=([java.lang.String[]], int)}
; {var1606=r0, var3988=null_type, var3662=$r1, var1672=r2, var2602=i1, var3874=$i0, var3742=$r3, var2512=$r4}
; {r0=var1606, null_type=var3988, $r1=var3662, r2=var1672, i1=var2602, $i0=var3874, $r3=var3742, $r4=var2512}
;seq <java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(2);	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto return r2;	$r3 = r2[i1];	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	r2[i1] = $r4;	i1 = i1 + 1;	goto [?= $i0 = lengthof r2];	$i0 = lengthof r2;	if i1 >= $i0 goto return r2;	return r2
;block_num 5
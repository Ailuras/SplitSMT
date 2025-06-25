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

(declare-sort var454 0)
(declare-sort var792 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var792 var792)
(declare-const var3293 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3293 null-String)))
(define-const var665 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(assert true)
(define-const var705 Int (length/-134980193 var3293)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i6 >= $i0 goto (branch) 
(assert (>= var665 var705)) ; Cond: i6 >= $i0 
 ; Statement: if i6 != 0 goto $i1 = i6 - 1 
(assert (not (= var665 0))) ; Cond: i6 != 0 
(define-const var2294 Int (- var665 1)) ; Statement: $i1 = i6 - 1 
(assert (and true (and (>= 0 0) (>= (str.len var3293) var2294) (>= var2294 0))))
(define-const var3057 String (substring/-1240304868 var3293 0 var2294)) ; Statement: $r6 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1) 
(assert true) ; Non Conditional
(define-const var3759 String var3057) ; Statement: r1 = $r6 
(define-const var2691 var792 null-var792) ; Statement: r7 = null 
(assert (not (and true (and (>= var665 0) (>= (str.len var3293) var665)))))
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-Int=([int], int)}
; {var3293=r0, var454=null_type, var665=i6, var705=$i0, var2294=$i1, var3057=$r6, var3759=r1, var792=org.springframework.javapoet.ClassName, var2691=r7, var2010=$r2, var3430=$i9, var394=$r4, var1094=$i3, var2326=i7}
; {r0=var3293, null_type=var454, i6=var665, $i0=var705, $i1=var2294, $r6=var3057, r1=var3759, org.springframework.javapoet.ClassName=var792, r7=var2691, $r2=var2010, $i9=var3430, $r4=var394, $i3=var1094, i7=var2326}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i6 = 0;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i6 >= $i0 goto (branch);	if i6 != 0 goto $i1 = i6 - 1;	$i1 = i6 - 1;	$r6 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, $i1);	r1 = $r6;	r7 = null;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6);	$i9 = (int) -1;	$r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9);	$i3 = lengthof $r4;	i7 = 0;	if i7 >= $i3 goto return r7;	return r7
;block_num 7
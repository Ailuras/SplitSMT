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

(declare-sort var3764 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun regionMatches/-1964120983 (String Bool Int String Int Int) Bool)
(declare-const null-String String)
(declare-const var3949 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3949 null-String)))
(declare-const var3 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3 null-String)))
 ; Statement: if r0 == null goto return 0 
(assert (not (= var3949 null-String))) ; Negate: Cond: r0 == null  
 ; Statement: if r1 == null goto return 0 
(assert (not (= var3 null-String))) ; Negate: Cond: r1 == null  
(assert true)
(define-const var535 Int (length/-134980193 var3949)) ; Statement: $i1 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true)
(define-const var425 Int (length/-134980193 var3)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
 ; Statement: if $i1 >= $i0 goto $i2 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (>= var535 var425)) ; Cond: $i1 >= $i0 
(assert true)
(define-const var1702 Int (length/-134980193 var3)) ; Statement: $i2 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert true)
(define-const var2378 Bool (regionMatches/-1964120983 var3949 (ite (= 1 1) true false) 0 var3 0 var1702)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean regionMatches(boolean,int,java.lang.String,int,int)>(1, 0, r1, 0, $i2) 
 ; Statement: return $z0 
(check-sat)
; {length/-134980193=([java.lang.String], int), regionMatches/-1964120983=([java.lang.String, boolean, int, java.lang.String, int, int], boolean)}
; {var3949=r0, var3764=null_type, var3=r1, var535=$i1, var425=$i0, var1702=$i2, var2378=$z0}
; {r0=var3949, null_type=var3764, r1=var3, $i1=var535, $i0=var425, $i2=var1702, $z0=var2378}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.String: boolean regionMatches(boolean,int,java.lang.String,int,int)>
;cnt {"<java.lang.String: int length()>": 3,"<java.lang.String: boolean regionMatches(boolean,int,java.lang.String,int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	if r0 == null goto return 0;	if r1 == null goto return 0;	$i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	if $i1 >= $i0 goto $i2 = virtualinvoke r1.<java.lang.String: int length()>();	$i2 = virtualinvoke r1.<java.lang.String: int length()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean regionMatches(boolean,int,java.lang.String,int,int)>(1, 0, r1, 0, $i2);	return $z0
;block_num 4
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

(declare-sort var817 0)
(declare-sort var2173 0)
(declare-sort var1966 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-const null-var817 var817)
(declare-const null-String String)
(declare-const var1966-TYPE ClassObject)
(declare-const var2118 var817) ; Statement: r31 := @parameter0: java.lang.ClassLoader 
(assert (not (= var2118 null-var817)))
(declare-const var1330 String) ; Statement: r32 := @parameter1: java.lang.String 
(assert (not (= var1330 null-String)))
(define-const var1886 Int 0) ; Statement: i4 = 0 
(assert true)
(define-const var1068 Int (indexOf/-1037706067 var1330 91)) ; Statement: i0 = virtualinvoke r32.<java.lang.String: int indexOf(int)>(91) 
 ; Statement: if i0 <= 0 goto (branch) 
(assert (<= var1068 0)) ; Cond: i0 <= 0 
 ; Statement: if i4 <= 0 goto $r0 = "void" 
(assert (<= var1886 0)) ; Cond: i4 <= 0 
(define-const var2136 String "void") ; Statement: $r0 = "void" 
(assert true)
(define-const var2501 Bool (= var2136 var1330)) ; Statement: $z0 = virtualinvoke $r0.<java.lang.String: boolean equals(java.lang.Object)>(r32) 
 ; Statement: if $z0 == 0 goto $r1 = "boolean" 
(assert (not (= (ite var2501 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2879 ClassObject var1966-TYPE) ; Statement: $r18 = <java.lang.Void: java.lang.Class TYPE> 
 ; Statement: return $r18 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int)}
; {var817=java.lang.ClassLoader, var2118=r31, var1330=r32, var2173=null_type, var1886=i4, var1068=i0, var2136=$r0, var2501=$z0, var1966=java.lang.Void, var2879=$r18}
; {java.lang.ClassLoader=var817, r31=var2118, r32=var1330, null_type=var2173, i4=var1886, i0=var1068, $r0=var2136, $z0=var2501, java.lang.Void=var1966, $r18=var2879}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r31 := @parameter0: java.lang.ClassLoader;	r32 := @parameter1: java.lang.String;	i4 = 0;	i0 = virtualinvoke r32.<java.lang.String: int indexOf(int)>(91);	if i0 <= 0 goto (branch);	if i4 <= 0 goto $r0 = "void";	$r0 = "void";	$z0 = virtualinvoke $r0.<java.lang.String: boolean equals(java.lang.Object)>(r32);	if $z0 == 0 goto $r1 = "boolean";	$r18 = <java.lang.Void: java.lang.Class TYPE>;	return $r18
;block_num 4
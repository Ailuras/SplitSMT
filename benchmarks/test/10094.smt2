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

(declare-sort var3020 0)
(declare-sort var2508 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3020 var3020)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1105 var3020) ; Statement: r5 := @this: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum$2 
(assert (not (= var1105 null-var3020)))
(declare-const var1995 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1995 null-String)))
(declare-const var1602 (Array Int String)) ; Statement: r2 := @parameter1: java.lang.String[] 
(assert (not (= var1602 null-__Array__Int__String__)))
(define-const var1170 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1170 var1995)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>(r1) 
(declare-const var1170!1 String)
(assert (= var1170!1 var1995))
(define-const var205 Int (getLength-Arr-String-1 var1602)) ; Statement: i0 = lengthof r2 
(define-const var2992 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var2992 var205)) ; Cond: i1 >= i0 
(assert true)
(define-const var177 String (toString/-2075883882 var1170!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), getLength-Arr-String-1=([java.lang.String[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3020=org.apache.dubbo.metadata.report.identifier.KeyTypeEnum$2, var1105=r5, var1995=r1, var2508=null_type, var1602=r2, var1170=$r0, var205=i0, var2992=i1, var177=$r3}
; {org.apache.dubbo.metadata.report.identifier.KeyTypeEnum$2=var3020, r5=var1105, r1=var1995, null_type=var2508, r2=var1602, $r0=var1170, i0=var205, i1=var2992, $r3=var177}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r5 := @this: org.apache.dubbo.metadata.report.identifier.KeyTypeEnum$2;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>(r1);	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3
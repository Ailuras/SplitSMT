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

(declare-sort var3768 0)
(declare-sort var1828 0)
(declare-sort var3066 0)
(declare-sort var1766 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3768_entrySet/1101202697 (var3768) var3066)
(declare-fun var3066_iterator/1911472585 (var3066) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var1766-init () var1766)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/294323258 (var1766 var1828 String) void)
(declare-const null-var3768 var3768)
(declare-const var1828-OK var1828)
(declare-const var1610 var3768) ; Statement: r1 := @parameter0: java.util.Map 
(assert (not (= var1610 null-var3768)))
(define-const var3245 var1828 var1828-OK) ; Statement: r16 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK> 
(define-const var1987 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1987)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1987!1 String)
(assert (= var1987!1 ""))
(define-const var761 var3066 (var3768_entrySet/1101202697 var1610)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map: java.util.Set entrySet()>() 
(define-const var2982 Iterator (var3066_iterator/1911472585 var761)) ; Statement: r3 = interfaceinvoke $r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2089 Bool (Iterator_hasNext/-1669924200 var2982)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = new org.apache.dubbo.common.status.Status 
(assert (= (ite var2089 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2049 var1766 var1766-init) ; Statement: $r4 = new org.apache.dubbo.common.status.Status 
(assert true)
(define-const var2040 String (toString/-2075883882 var1987!1)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/294323258 var2049 var3245 var2040)) ; Statement: specialinvoke $r4.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r16, $r5) 

(declare-const var2049!1 var1766)
(declare-const var3245!1 var1828)
(declare-const var2040!1 String)
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3768_entrySet/1101202697=([java.util.Map], java.util.Set), var3066_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var1766-init=([], org.apache.dubbo.common.status.Status), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/294323258=([org.apache.dubbo.common.status.Status, org.apache.dubbo.common.status.Status$Level, java.lang.String], void)}
; {var3768=java.util.Map, var1610=r1, var1828=org.apache.dubbo.common.status.Status$Level, var3245=r16, var1987=$r0, var3066=java.util.Set, var761=$r2, var2982=r3, var2089=$z0, var1766=org.apache.dubbo.common.status.Status, var2049=$r4, var2040=$r5}
; {java.util.Map=var3768, r1=var1610, org.apache.dubbo.common.status.Status$Level=var1828, r16=var3245, $r0=var1987, java.util.Set=var3066, $r2=var761, r3=var2982, $z0=var2089, org.apache.dubbo.common.status.Status=var1766, $r4=var2049, $r5=var2040}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.Map;	r16 = <org.apache.dubbo.common.status.Status$Level: org.apache.dubbo.common.status.Status$Level OK>;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<java.util.Map: java.util.Set entrySet()>();	r3 = interfaceinvoke $r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = new org.apache.dubbo.common.status.Status;	$r4 = new org.apache.dubbo.common.status.Status;	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.common.status.Status: void <init>(org.apache.dubbo.common.status.Status$Level,java.lang.String)>(r16, $r5);	return $r4
;block_num 3
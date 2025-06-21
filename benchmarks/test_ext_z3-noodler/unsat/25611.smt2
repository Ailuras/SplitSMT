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

(declare-sort var2328 0)
(declare-sort var2542 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2328 var2328)
(declare-const null-String String)
(declare-const var3470 var2328) ; Statement: r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping 
(assert (not (= var3470 null-var2328)))
(declare-const var402 String) ; Statement: r11 := @parameter0: java.lang.String 
(assert (not (= var402 null-String)))
(declare-const var1198 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1198 null-String)))
(declare-const var602 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var602 null-String)))
 ; Statement: if r11 != null goto (branch) 
(assert (not (= var402 null-String))) ; Cond: r11 != null 
 ; Statement: if r0 == null goto (branch) 
(assert (= var1198 null-String)) ; Cond: r0 == null 
 ; Statement: if r1 != null goto $r2 = new java.lang.StringBuilder 
(assert (not (= var602 null-String))) ; Cond: r1 != null 
(define-const var1045 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1045)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1045!1 String)
(assert (= var1045!1 ""))
(assert true)
(define-const var877 String (append/672562846 var1045!1 var402)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11) 
(declare-const var1045!2 String)
(assert (= var1045!2 (str.++ var1045!1 var402)))
(assert true)
(define-const var32 String (append/-1166366385 var877 126)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(126) 
(declare-const var877!1 String)
(assert (str.prefixof var877 var877!1))
(assert true)
(define-const var3597 String (append/672562846 var32 var602)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var32!1 String)
(assert (= var32!1 (str.++ var32 var602)))
(assert true)
(define-const var1912 String (toString/-2075883882 var3597)) ; Statement: $r12 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2328=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping, var3470=r10, var402=r11, var2542=null_type, var1198=r0, var602=r1, var1045=$r2, var877=$r3, var32=$r4, var3597=$r5, var1912=$r12}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping=var2328, r10=var3470, r11=var402, null_type=var2542, r0=var1198, r1=var602, $r2=var1045, $r3=var877, $r4=var32, $r5=var3597, $r12=var1912}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMapping;	r11 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	if r11 != null goto (branch);	if r0 == null goto (branch);	if r1 != null goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r11);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(126);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r12 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 5
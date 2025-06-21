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

(declare-sort var3509 0)
(declare-sort var1737 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun hasAdaptiveMethod/1631267926 (var3509) Bool)
(declare-fun var1737-init () var1737)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun type/-670994832 (var3509) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1737 String) void)
(declare-const null-var3509 var3509)
(declare-const null-Bool Bool)
(declare-const var2217 var3509) ; Statement: r0 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var2217 null-var3509)))
(declare-const var1653 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var1653 null-Bool)))
(assert true)
(define-const var2181 Bool (hasAdaptiveMethod/1631267926 var2217)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: boolean hasAdaptiveMethod()>() 
 ; Statement: if $z0 != 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (not (= (ite var2181 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3586 var1737 var1737-init) ; Statement: $r15 = new java.lang.IllegalStateException 
(define-const var3595 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3595)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3595!1 String)
(assert (= var3595!1 ""))
(assert true)
(define-const var2012 String (append/672562846 var3595!1 "No adaptive method exist on extension ")) ; Statement: $r19 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No adaptive method exist on extension ") 
(declare-const var3595!2 String)
(assert (= var3595!2 (str.++ var3595!1 "No adaptive method exist on extension ")))
(define-const var2242 ClassObject (type/-670994832 var2217)) ; Statement: $r17 = r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var1279 String (getName/-1958580599 var2242)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3794 String (append/672562846 var2012 var1279)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var2012!1 String)
(assert (= var2012!1 (str.++ var2012 var1279)))
(assert true)
(define-const var1649 String (append/672562846 var3794 ", refuse to create the adaptive class!")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", refuse to create the adaptive class!") 
(declare-const var3794!1 String)
(assert (= var3794!1 (str.++ var3794 ", refuse to create the adaptive class!")))
(assert true)
(define-const var1018 String (toString/-2075883882 var1649)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var3586 var1018)) ; Statement: specialinvoke $r15.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r22) 

(declare-const var3586!1 var1737)
(declare-const var1018!1 String)
 ; Statement: throw $r15 
(check-sat)
; {hasAdaptiveMethod/1631267926=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], boolean), var1737-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3509=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var2217=r0, var1653=z1, var2181=$z0, var1737=java.lang.IllegalStateException, var3586=$r15, var3595=$r16, var2012=$r19, var2242=$r17, var1279=$r18, var3794=$r20, var1649=$r21, var1018=$r22}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var3509, r0=var2217, z1=var1653, $z0=var2181, java.lang.IllegalStateException=var1737, $r15=var3586, $r16=var3595, $r19=var2012, $r17=var2242, $r18=var1279, $r20=var3794, $r21=var1649, $r22=var1018}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	z1 := @parameter0: boolean;	$z0 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: boolean hasAdaptiveMethod()>();	if $z0 != 0 goto $r1 = new java.lang.StringBuilder;	$r15 = new java.lang.IllegalStateException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No adaptive method exist on extension ");	$r17 = r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	$r18 = virtualinvoke $r17.<java.lang.Class: java.lang.String getName()>();	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", refuse to create the adaptive class!");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r15.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r22);	throw $r15
;block_num 2
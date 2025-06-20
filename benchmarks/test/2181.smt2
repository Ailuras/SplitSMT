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

(declare-sort var737 0)
(declare-sort var1412 0)
(declare-sort var779 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun hasAdaptiveMethod/1631267926 (var737) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun generatePackageInfo/30161063 (var737) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun generateImports/1897257485 (var737) String)
(declare-fun generateClassDeclaration/1273559581 (var737) String)
(declare-fun type/-670994832 (var737) ClassObject)
(declare-fun getMethods/-297347657 (ClassObject) (Array Int var1412))
(declare-fun getLength-Arr-var1412-1 ((Array Int var1412)) Int)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var779_isDebugEnabled/-823448366 (var779) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var737 var737)
(declare-const null-Bool Bool)
(declare-const var737-logger var779)
(declare-const var307 var737) ; Statement: r0 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var307 null-var737)))
(declare-const var3099 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var3099 null-Bool)))
(assert true)
(define-const var3037 Bool (hasAdaptiveMethod/1631267926 var307)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: boolean hasAdaptiveMethod()>() 
 ; Statement: if $z0 != 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (= (ite var3037 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1308 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1308)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1308!1 String)
(assert (= var1308!1 ""))
(assert true)
(define-const var655 String (generatePackageInfo/30161063 var307)) ; Statement: $r2 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generatePackageInfo()>() 
(assert true)
;(assert (append/672562846 var1308!1 var655)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1308!2 String)
(assert (= var1308!2 (str.++ var1308!1 var655)))
(assert true)
(define-const var50 String (generateImports/1897257485 var307)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateImports()>() 
(assert true)
;(assert (append/672562846 var1308!2 var50)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1308!3 String)
(assert (= var1308!3 (str.++ var1308!2 var50)))
(assert true)
(define-const var3364 String (generateClassDeclaration/1273559581 var307)) ; Statement: $r4 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateClassDeclaration()>() 
(assert true)
;(assert (append/672562846 var1308!3 var3364)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1308!4 String)
(assert (= var1308!4 (str.++ var1308!3 var3364)))
(define-const var3121 ClassObject (type/-670994832 var307)) ; Statement: $r5 = r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type> 
(assert true)
(define-const var2045 (Array Int var1412) (getMethods/-297347657 var3121)) ; Statement: r6 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method[] getMethods()>() 
 ; Statement: if z1 == 0 goto $i0 = lengthof r6 
(assert (= (ite var3099 1 0) 0)) ; Cond: z1 == 0 
(define-const var673 Int (getLength-Arr-var1412-1 var2045)) ; Statement: $i0 = lengthof r6 
(define-const var656 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (>= var656 var673)) ; Cond: i1 >= $i0 
(assert true)
;(assert (append/-1166366385 var1308!4 125)) ; Statement: virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1308!5 String)
(assert (str.prefixof var1308!4 var1308!5))
(define-const var496 var779 var737-logger) ; Statement: $r7 = <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: org.apache.dubbo.common.logger.Logger logger> 
(define-const var2319 Bool (var779_isDebugEnabled/-823448366 var496)) ; Statement: $z2 = interfaceinvoke $r7.<org.apache.dubbo.common.logger.Logger: boolean isDebugEnabled()>() 
 ; Statement: if $z2 == 0 goto $r8 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2319 1 0) 0)) ; Cond: $z2 == 0 
(assert true)
(define-const var392 String (toString/-2075883882 var1308!5)) ; Statement: $r8 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {hasAdaptiveMethod/1631267926=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), generatePackageInfo/30161063=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), generateImports/1897257485=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.String), generateClassDeclaration/1273559581=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.String), type/-670994832=([org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator], java.lang.Class), getMethods/-297347657=([java.lang.Class], java.lang.reflect.Method[]), getLength-Arr-var1412-1=([java.lang.reflect.Method[]], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var779_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var737=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var307=r0, var3099=z1, var3037=$z0, var1308=$r1, var655=$r2, var50=$r3, var3364=$r4, var3121=$r5, var1412=java.lang.reflect.Method, var2045=r6, var673=$i0, var656=i1, var779=org.apache.dubbo.common.logger.Logger, var496=$r7, var2319=$z2, var392=$r8}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var737, r0=var307, z1=var3099, $z0=var3037, $r1=var1308, $r2=var655, $r3=var50, $r4=var3364, $r5=var3121, java.lang.reflect.Method=var1412, r6=var2045, $i0=var673, i1=var656, org.apache.dubbo.common.logger.Logger=var779, $r7=var496, $z2=var2319, $r8=var392}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	z1 := @parameter0: boolean;	$z0 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: boolean hasAdaptiveMethod()>();	if $z0 != 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generatePackageInfo()>();	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateImports()>();	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r4 = specialinvoke r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.String generateClassDeclaration()>();	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r5 = r0.<org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: java.lang.Class type>;	r6 = virtualinvoke $r5.<java.lang.Class: java.lang.reflect.Method[] getMethods()>();	if z1 == 0 goto $i0 = lengthof r6;	$i0 = lengthof r6;	i1 = 0;	if i1 >= $i0 goto virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r7 = <org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator: org.apache.dubbo.common.logger.Logger logger>;	$z2 = interfaceinvoke $r7.<org.apache.dubbo.common.logger.Logger: boolean isDebugEnabled()>();	if $z2 == 0 goto $r8 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 6
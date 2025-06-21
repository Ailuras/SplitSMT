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

(declare-sort var1215 0)
(declare-sort var2657 0)
(declare-sort var1509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun getName/1939356413 (var1215) String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getParameterTypes/354906766 (var1215) (Array Int var2657))
(declare-fun getLength-Arr-var2657-1 ((Array Int var2657)) Int)
(declare-fun getReturnType/1890016246 (var1215) var2657)
(declare-fun var1509_getDesc/343986570 (var2657) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1215 var1215)
(declare-const var165 var1215) ; Statement: r1 := @parameter0: javassist.CtMethod 
(assert (not (= var165 null-var1215)))
(define-const var3140 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
(define-const var95 String (getName/1939356413 var165)) ; Statement: $r2 = virtualinvoke r1.<javassist.CtMethod: java.lang.String getName()>() 
(assert true)
;(assert (<init>/-1061048412 var3140 var95)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2) 
(declare-const var3140!1 String)
(assert (= var3140!1 var95))
(assert true)
(define-const var3446 String (append/-1166366385 var3140!1 40)) ; Statement: r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var3140!2 String)
(assert (str.prefixof var3140!1 var3140!2))
(assert true)
(define-const var3641 (Array Int var2657) (getParameterTypes/354906766 var165)) ; Statement: r4 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass[] getParameterTypes()>() 
(define-const var2040 Int (getLength-Arr-var2657-1 var3641)) ; Statement: i0 = lengthof r4 
(define-const var2171 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var2171 var2040)) ; Cond: i1 >= i0 
(assert true)
(define-const var3822 String (append/-1166366385 var3446 41)) ; Statement: $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var3446!1 String)
(assert (str.prefixof var3446 var3446!1))
(assert true)
(define-const var1466 var2657 (getReturnType/1890016246 var165)) ; Statement: $r5 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass getReturnType()>() 
(define-const var2170 String (var1509_getDesc/343986570 var1466)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r5) 
(assert true)
;(assert (append/672562846 var3822 var2170)) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3822!1 String)
(assert (= var3822!1 (str.++ var3822 var2170)))
(assert true)
(define-const var2505 String (toString/-2075883882 var3446!1)) ; Statement: $r8 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), getName/1939356413=([javassist.CtMethod], java.lang.String), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getParameterTypes/354906766=([javassist.CtMethod], javassist.CtClass[]), getLength-Arr-var2657-1=([javassist.CtClass[]], int), getReturnType/1890016246=([javassist.CtMethod], javassist.CtClass), var1509_getDesc/343986570=([javassist.CtClass], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1215=javassist.CtMethod, var165=r1, var3140=$r0, var95=$r2, var3446=r3, var2657=javassist.CtClass, var3641=r4, var2040=i0, var2171=i1, var3822=$r7, var1466=$r5, var1509=org.apache.dubbo.common.utils.ReflectUtils, var2170=$r6, var2505=$r8}
; {javassist.CtMethod=var1215, r1=var165, $r0=var3140, $r2=var95, r3=var3446, javassist.CtClass=var2657, r4=var3641, i0=var2040, i1=var2171, $r7=var3822, $r5=var1466, org.apache.dubbo.common.utils.ReflectUtils=var1509, $r6=var2170, $r8=var2505}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: javassist.CtMethod;	$r0 = new java.lang.StringBuilder;	$r2 = virtualinvoke r1.<javassist.CtMethod: java.lang.String getName()>();	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>($r2);	r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r4 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass[] getParameterTypes()>();	i0 = lengthof r4;	i1 = 0;	if i1 >= i0 goto $r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r7 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r5 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass getReturnType()>();	$r6 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r5);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 3
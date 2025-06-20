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

(declare-sort var762 0)
(declare-sort var3516 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun isArray/582308305 (var762) Bool)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getComponentType/330921138 (var762) var762)
(declare-fun var3516_getDesc/343986570 (var762) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var762 var762)
(declare-const var3302 var762) ; Statement: r1 := @parameter0: javassist.CtClass 
(assert (not (= var3302 null-var762)))
(define-const var2020 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2020)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2020!1 String)
(assert (= var2020!1 ""))
(assert true)
(define-const var2432 Bool (isArray/582308305 var3302)) ; Statement: $z0 = virtualinvoke r1.<javassist.CtClass: boolean isArray()>() 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r1.<javassist.CtClass: boolean isPrimitive()>() 
(assert (not (= (ite var2432 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (append/-1166366385 var2020!1 91)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91) 
(declare-const var2020!2 String)
(assert (str.prefixof var2020!1 var2020!2))
(assert true)
(define-const var3569 var762 (getComponentType/330921138 var3302)) ; Statement: $r14 = virtualinvoke r1.<javassist.CtClass: javassist.CtClass getComponentType()>() 
(define-const var2840 String (var3516_getDesc/343986570 var3569)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r14) 
(assert true)
;(assert (append/672562846 var2020!2 var2840)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var2020!3 String)
(assert (= var2020!3 (str.++ var2020!2 var2840)))
 ; Statement: goto [?= $r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var2633 String (toString/-2075883882 var2020!3)) ; Statement: $r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r16 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), isArray/582308305=([javassist.CtClass], boolean), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getComponentType/330921138=([javassist.CtClass], javassist.CtClass), var3516_getDesc/343986570=([javassist.CtClass], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var762=javassist.CtClass, var3302=r1, var2020=$r0, var2432=$z0, var3569=$r14, var3516=org.apache.dubbo.common.utils.ReflectUtils, var2840=$r15, var2633=$r16}
; {javassist.CtClass=var762, r1=var3302, $r0=var2020, $z0=var2432, $r14=var3569, org.apache.dubbo.common.utils.ReflectUtils=var3516, $r15=var2840, $r16=var2633}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: javassist.CtClass;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$z0 = virtualinvoke r1.<javassist.CtClass: boolean isArray()>();	if $z0 == 0 goto $z1 = virtualinvoke r1.<javassist.CtClass: boolean isPrimitive()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(91);	$r14 = virtualinvoke r1.<javassist.CtClass: javassist.CtClass getComponentType()>();	$r15 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r14);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	goto [?= $r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>()];	$r16 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r16
;block_num 3
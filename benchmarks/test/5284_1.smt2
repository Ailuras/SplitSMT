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

(declare-sort var3749 0)
(declare-sort var1321 0)
(declare-sort var2262 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getParameterTypes/354906766 (var3749) (Array Int var1321))
(declare-fun getLength-Arr-var1321-1 ((Array Int var1321)) Int)
(declare-fun getReturnType/1890016246 (var3749) var1321)
(declare-fun var2262_getDesc/343986570 (var1321) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3749 var3749)
(declare-const var3486 var3749) ; Statement: r1 := @parameter0: javassist.CtMethod 
(assert (not (= var3486 null-var3749)))
(define-const var1690 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1690)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1690!1 String)
(assert (= var1690!1 ""))
(assert true)
;(assert (append/-1166366385 var1690!1 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1690!2 String)
(assert (str.prefixof var1690!1 var1690!2))
(assert true)
(define-const var1330 (Array Int var1321) (getParameterTypes/354906766 var3486)) ; Statement: r2 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass[] getParameterTypes()>() 
(define-const var168 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var475 Int (getLength-Arr-var1321-1 var1330)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(assert (>= var168 var475)) ; Cond: i1 >= $i0 
(assert true)
(define-const var1534 String (append/-1166366385 var1690!2 41)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41) 
(declare-const var1690!3 String)
(assert (str.prefixof var1690!2 var1690!3))
(assert true)
(define-const var1291 var1321 (getReturnType/1890016246 var3486)) ; Statement: $r3 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass getReturnType()>() 
(define-const var2416 String (var2262_getDesc/343986570 var1291)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r3) 
(assert true)
;(assert (append/672562846 var1534 var2416)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1534!1 String)
(assert (= var1534!1 (str.++ var1534 var2416)))
(assert true)
(define-const var3051 String (toString/-2075883882 var1690!3)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getParameterTypes/354906766=([javassist.CtMethod], javassist.CtClass[]), getLength-Arr-var1321-1=([javassist.CtClass[]], int), getReturnType/1890016246=([javassist.CtMethod], javassist.CtClass), var2262_getDesc/343986570=([javassist.CtClass], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3749=javassist.CtMethod, var3486=r1, var1690=$r0, var1321=javassist.CtClass, var1330=r2, var168=i1, var475=$i0, var1534=$r5, var1291=$r3, var2262=org.apache.dubbo.common.utils.ReflectUtils, var2416=$r4, var3051=$r6}
; {javassist.CtMethod=var3749, r1=var3486, $r0=var1690, javassist.CtClass=var1321, r2=var1330, i1=var168, $i0=var475, $r5=var1534, $r3=var1291, org.apache.dubbo.common.utils.ReflectUtils=var2262, $r4=var2416, $r6=var3051}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: javassist.CtMethod;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	r2 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass[] getParameterTypes()>();	i1 = 0;	$i0 = lengthof r2;	if i1 >= $i0 goto $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(41);	$r3 = virtualinvoke r1.<javassist.CtMethod: javassist.CtClass getReturnType()>();	$r4 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getDesc(javassist.CtClass)>($r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3
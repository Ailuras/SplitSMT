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

(declare-sort var3482 0)
(declare-sort var1328 0)
(declare-sort var1485 0)
(declare-sort var2738 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun element/-1030843987 (var3482) var1328)
(declare-fun append/-1031950772 (String var1485) String)
(declare-fun cast-from-var1328-to-var1485 (var1328) var1485)
(declare-fun annotation/-1030843987 (var3482) var2738)
(declare-fun cast-from-var2738-to-var1485 (var2738) var1485)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3482 var3482)
(declare-const var3260 var3482) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var3260 null-var3482)))
(define-const var3524 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3524)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3524!1 String)
(assert (= var3524!1 ""))
(assert true)
(define-const var702 String (append/672562846 var3524!1 "AnnotationMeta{element=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AnnotationMeta{element=") 
(declare-const var3524!2 String)
(assert (= var3524!2 (str.++ var3524!1 "AnnotationMeta{element=")))
(define-const var1568 var1328 (element/-1030843987 var3260)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.reflect.AnnotatedElement element> 
(assert true)
(define-const var3724 String (append/-1031950772 var702 (cast-from-var1328-to-var1485 var1568))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var702!1 String)
(assert (str.prefixof var702 var702!1))
(assert true)
(define-const var1085 String (append/672562846 var3724 ", annotation=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", annotation=") 
(declare-const var3724!1 String)
(assert (= var3724!1 (str.++ var3724 ", annotation=")))
(define-const var2272 var2738 (annotation/-1030843987 var3260)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.'annotation'.Annotation 'annotation'> 
(assert true)
(define-const var437 String (append/-1031950772 var1085 (cast-from-var2738-to-var1485 var2272))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var1085!1 String)
(assert (str.prefixof var1085 var1085!1))
(assert true)
(define-const var1362 String (append/-1166366385 var437 125)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var437!1 String)
(assert (str.prefixof var437 var437!1))
(assert true)
(define-const var3316 String (toString/-2075883882 var1362)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), element/-1030843987=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.reflect.AnnotatedElement), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1328-to-var1485=([java.lang.reflect.AnnotatedElement], java.lang.Object), annotation/-1030843987=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.annotation.Annotation), cast-from-var2738-to-var1485=([java.lang.annotation.Annotation], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3482=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var3260=r1, var3524=$r0, var702=$r3, var1328=java.lang.reflect.AnnotatedElement, var1568=$r2, var1485=java.lang.Object, var3724=$r4, var1085=$r6, var2738=java.lang.annotation.Annotation, var2272=$r5, var437=$r7, var1362=$r8, var3316=$r9}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var3482, r1=var3260, $r0=var3524, $r3=var702, java.lang.reflect.AnnotatedElement=var1328, $r2=var1568, java.lang.Object=var1485, $r4=var3724, $r6=var1085, java.lang.annotation.Annotation=var2738, $r5=var2272, $r7=var437, $r8=var1362, $r9=var3316}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("AnnotationMeta{element=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.reflect.AnnotatedElement element>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", annotation=");	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.'annotation'.Annotation 'annotation'>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1
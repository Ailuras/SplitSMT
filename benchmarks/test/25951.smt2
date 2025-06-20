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

(declare-sort var288 0)
(declare-sort var3194 0)
(declare-sort var3481 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun field/770284873 (var288) var3194)
(declare-fun append/-1031950772 (String var3481) String)
(declare-fun cast-from-var3194-to-var3481 (var3194) var3481)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var288 var288)
(declare-const var1711 var288) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta 
(assert (not (= var1711 null-var288)))
(define-const var3243 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3243)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3243!1 String)
(assert (= var3243!1 ""))
(assert true)
(define-const var1757 String (append/672562846 var3243!1 "FieldParameter{")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("FieldParameter{") 
(declare-const var3243!2 String)
(assert (= var3243!2 (str.++ var3243!1 "FieldParameter{")))
(define-const var2105 var3194 (field/770284873 var1711)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta: java.lang.reflect.Field field> 
(assert true)
(define-const var3624 String (append/-1031950772 var1757 (cast-from-var3194-to-var3481 var2105))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1757!1 String)
(assert (str.prefixof var1757 var1757!1))
(assert true)
(define-const var3335 String (append/-1166366385 var3624 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3624!1 String)
(assert (str.prefixof var3624 var3624!1))
(assert true)
(define-const var2852 String (toString/-2075883882 var3335)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), field/770284873=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta], java.lang.reflect.Field), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3194-to-var3481=([java.lang.reflect.Field], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var288=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta, var1711=r1, var3243=$r0, var1757=$r3, var3194=java.lang.reflect.Field, var2105=$r2, var3481=java.lang.Object, var3624=$r4, var3335=$r5, var2852=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta=var288, r1=var1711, $r0=var3243, $r3=var1757, java.lang.reflect.Field=var3194, $r2=var2105, java.lang.Object=var3481, $r4=var3624, $r5=var3335, $r6=var2852}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("FieldParameter{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.BeanMeta$FieldMeta: java.lang.reflect.Field field>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1
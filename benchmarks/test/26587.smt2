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

(declare-sort var1267 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun negated/1926907315 (var1267) Bool)
(declare-fun type/1926907315 (var1267) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun subType/1926907315 (var1267) String)
(declare-fun quality/1926907315 (var1267) Float32)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1267 var1267)
(declare-const var3858 var1267) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression 
(assert (not (= var3858 null-var1267)))
(define-const var465 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var465)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var465!1 String)
(assert (= var465!1 ""))
(define-const var3085 Bool (negated/1926907315 var3858)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: boolean negated> 
 ; Statement: if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type> 
(assert (= (ite var3085 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3516 String (type/1926907315 var3858)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type> 
(assert true)
(define-const var2980 String (append/672562846 var465!1 var3516)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var465!2 String)
(assert (= var465!2 (str.++ var465!1 var3516)))
(assert true)
(define-const var3599 String (append/-1166366385 var2980 47)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var2980!1 String)
(assert (str.prefixof var2980 var2980!1))
(define-const var399 String (subType/1926907315 var3858)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType> 
(assert true)
;(assert (append/672562846 var3599 var399)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3599!1 String)
(assert (= var3599!1 (str.++ var3599 var399)))
(define-const var1807 Float32 (quality/1926907315 var3858)) ; Statement: $f0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: float quality> 
(define-const var414 Int (ite (fp.gt var1807 ((_ to_fp 8 24) #x3f800000)) 1 (ite (fp.lt var1807 ((_ to_fp 8 24) #x3f800000)) -1 0))) ; Statement: $b0 = $f0 cmpl 1.0F 
 ; Statement: if $b0 == 0 goto $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var414 0)) ; Cond: $b0 == 0 
(assert true)
(define-const var3397 String (toString/-2075883882 var465!2)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), negated/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], boolean), type/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), subType/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String), quality/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], float), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1267=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression, var3858=r1, var465=$r0, var3085=$z0, var3516=$r2, var2980=$r3, var3599=$r5, var399=$r4, var1807=$f0, var414=$b0, var3397=$r6}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression=var1267, r1=var3858, $r0=var465, $z0=var3085, $r2=var3516, $r3=var2980, $r5=var3599, $r4=var399, $f0=var1807, $b0=var414, $r6=var3397}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$z0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: boolean negated>;	if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type>;	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType>;	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$f0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: float quality>;	$b0 = $f0 cmpl 1.0F;	if $b0 == 0 goto $r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3
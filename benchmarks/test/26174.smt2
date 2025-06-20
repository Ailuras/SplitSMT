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

(declare-sort var2334 0)
(declare-sort var3377 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun status/1704592383 (var2334) Int)
(declare-fun reason/1704592383 (var2334) String)
(declare-fun var3377_isNotEmpty/-1251449450 (String) Bool)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2334 var2334)
(declare-const null-Int Int)
(declare-const var1691 var2334) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta 
(assert (not (= var1691 null-var2334)))
(define-const var688 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var688 "ResponseMeta{")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("ResponseMeta{") 
(declare-const var688!1 String)
(assert (= var688!1 "ResponseMeta{"))
(define-const var926 Int (status/1704592383 var1691)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.Integer status> 
 ; Statement: if $r2 == null goto $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.String reason> 
(assert (= var926 null-Int)) ; Cond: $r2 == null 
(define-const var678 String (reason/1704592383 var1691)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.String reason> 
(define-const var3721 Bool (var3377_isNotEmpty/-1251449450 var678)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= (ite var3721 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/-1166366385 var688!1 125)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var688!2 String)
(assert (str.prefixof var688!1 var688!2))
(assert true)
(define-const var1678 String (toString/-2075883882 var688!2)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), status/1704592383=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta], java.lang.Integer), reason/1704592383=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta], java.lang.String), var3377_isNotEmpty/-1251449450=([java.lang.String], boolean), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2334=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta, var1691=r1, var688=$r0, var926=$r2, var678=$r3, var3377=org.apache.dubbo.common.utils.StringUtils, var3721=$z0, var1678=$r4}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta=var2334, r1=var1691, $r0=var688, $r2=var926, $r3=var678, org.apache.dubbo.common.utils.StringUtils=var3377, $z0=var3721, $r4=var1678}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("ResponseMeta{");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.Integer status>;	if $r2 == null goto $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.String reason>;	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ResponseMeta: java.lang.String reason>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 3
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

(declare-sort var190 0)
(declare-sort var2094 0)
(declare-sort var2833 0)
(declare-sort var1057 0)
(declare-sort var393 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun type/434063243 (var190) var2094)
(declare-fun append/-1031950772 (String var2833) String)
(declare-fun cast-from-var2094-to-var2833 (var2094) var2833)
(declare-fun value/434063243 (var190) String)
(declare-fun variables/434063243 (var190) var393)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var190 var190)
(declare-const null-String String)
(declare-const null-var393 var393)
(declare-const var3984 var190) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment 
(assert (not (= var3984 null-var190)))
(define-const var3353 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var3353 "{type=")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("{type=") 
(declare-const var3353!1 String)
(assert (= var3353!1 "{type="))
(define-const var3164 var2094 (type/434063243 var3984)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type type> 
(assert true)
;(assert (append/-1031950772 var3353!1 (cast-from-var2094-to-var2833 var3164))) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var3353!2 String)
(assert (str.prefixof var3353!1 var3353!2))
(define-const var2169 String (value/434063243 var3984)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value> 
 ; Statement: if $r3 == null goto $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.util.List variables> 
(assert (= var2169 null-String)) ; Cond: $r3 == null 
(define-const var943 var393 (variables/434063243 var3984)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.util.List variables> 
 ; Statement: if $r4 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(assert (= var943 null-var393)) ; Cond: $r4 == null 
(assert true)
;(assert (append/-1166366385 var3353!2 125)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var3353!3 String)
(assert (str.prefixof var3353!2 var3353!3))
(assert true)
(define-const var1277 String (toString/-2075883882 var3353!3)) ; Statement: $r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r5 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), type/434063243=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2094-to-var2833=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type], java.lang.Object), value/434063243=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], java.lang.String), variables/434063243=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], java.util.List), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var190=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var3984=r1, var3353=$r0, var2094=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, var3164=$r2, var2833=java.lang.Object, var2169=$r3, var1057=null_type, var393=java.util.List, var943=$r4, var1277=$r5}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var190, r1=var3984, $r0=var3353, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type=var2094, $r2=var3164, java.lang.Object=var2833, $r3=var2169, null_type=var1057, java.util.List=var393, $r4=var943, $r5=var1277}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("{type=");	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type type>;	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value>;	if $r3 == null goto $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.util.List variables>;	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.util.List variables>;	if $r4 == null goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r5 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r5
;block_num 3
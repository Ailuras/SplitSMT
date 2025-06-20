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

(declare-sort var1587 0)
(declare-sort var474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun toCamelCase/-1976983181 (var1587 String) String)
(declare-const null-var1587 var1587)
(declare-const null-String String)
(declare-const var2978 var1587) ; Statement: r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var2978 null-var1587)))
(declare-const var3854 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3854 null-String)))
(assert (not (and true (and (>= 6 0) (>= (str.len var3854) 6)))))
(check-sat)
; {substring/850833817=([java.lang.String, int], java.lang.String), toCamelCase/-1976983181=([org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, java.lang.String], java.lang.String)}
; {var1587=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var2978=r0, var3854=r1, var474=null_type, var1523=$r2, var138=$r3}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1587, r0=var2978, r1=var3854, null_type=var474, $r2=var1523, $r3=var138}
;seq <java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r1 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(6);	$r3 = specialinvoke r0.<org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.lang.String toCamelCase(java.lang.String)>($r2);	return $r3
;block_num 1
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

(declare-sort var3726 0)
(declare-sort var2812 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun toCamelCase/-1976983181 (var3726 String) String)
(declare-const null-var3726 var3726)
(declare-const null-String String)
(declare-const var1485 var3726) ; Statement: r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1485 null-var3726)))
(declare-const var3184 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3184 null-String)))
(assert (not (and true (and (>= 3 0) (>= (str.len var3184) 3)))))
(check-sat)
; {substring/850833817=([java.lang.String, int], java.lang.String), toCamelCase/-1976983181=([org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, java.lang.String], java.lang.String)}
; {var3726=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1485=r0, var3184=r1, var2812=null_type, var3503=$r2, var1109=$r3}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var3726, r0=var1485, r1=var3184, null_type=var2812, $r2=var3503, $r3=var1109}
;seq <java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r1 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int)>(3);	$r3 = specialinvoke r0.<org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.lang.String toCamelCase(java.lang.String)>($r2);	return $r3
;block_num 1
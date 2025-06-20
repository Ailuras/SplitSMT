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

(declare-sort var328 0)
(declare-sort var1916 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun toCamelCase/-1976983181 (var328 String) String)
(declare-const null-var328 var328)
(declare-const null-String String)
(declare-const var1396 var328) ; Statement: r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1396 null-var328)))
(declare-const var1782 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1782 null-String)))
(assert true)
(define-const var582 Int (length/-134980193 var1782)) ; Statement: $i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var3533 Int (- var582 4)) ; Statement: $i1 = $i0 - 4 
(assert (and true (and (>= 3 0) (>= (str.len var1782) var3533) (>= var3533 3))))
(define-const var3436 String (substring/-1240304868 var1782 3 var3533)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(3, $i1) 
(assert true)
(define-const var3866 String (toCamelCase/-1976983181 var1396 var3436)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.lang.String toCamelCase(java.lang.String)>($r2) 
 ; Statement: return $r3 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toCamelCase/-1976983181=([org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, java.lang.String], java.lang.String)}
; {var328=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1396=r0, var1782=r1, var1916=null_type, var582=$i0, var3533=$i1, var3436=$r2, var3866=$r3}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var328, r0=var1396, r1=var1782, null_type=var1916, $i0=var582, $i1=var3533, $r2=var3436, $r3=var3866}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r1 := @parameter0: java.lang.String;	$i0 = virtualinvoke r1.<java.lang.String: int length()>();	$i1 = $i0 - 4;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String substring(int,int)>(3, $i1);	$r3 = specialinvoke r0.<org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.lang.String toCamelCase(java.lang.String)>($r2);	return $r3
;block_num 1
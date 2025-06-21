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

(declare-sort var2342 0)
(declare-sort var3876 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2342-to-var3876 (var2342) var3876)
(declare-fun cast-from-var3876-to-var2342 (var3876) var2342)
(declare-fun getService/-1311689935 (var2342) String)
(declare-const null-var2342 var2342)
(declare-const null-var3876 var3876)
(declare-const var2737 var2342) ; Statement: r1 := @this: io.grpc.health.v1.HealthCheckRequest 
(assert (not (= var2737 null-var2342)))
(declare-const var1379 var3876) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var1379 null-var3876)))
 ; Statement: if r0 != r1 goto $z0 = r0 instanceof io.grpc.health.v1.HealthCheckRequest 
(assert (not (= var1379 (cast-from-var2342-to-var3876 var2737)))) ; Cond: r0 != r1 
(define-const var2337 Bool false) ; Statement: $z0 = r0 instanceof io.grpc.health.v1.HealthCheckRequest 
 ; Statement: if $z0 != 0 goto r2 = (io.grpc.health.v1.HealthCheckRequest) r0 
(assert (not (= (ite var2337 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2540 var2342 (cast-from-var3876-to-var2342 var1379)) ; Statement: r2 = (io.grpc.health.v1.HealthCheckRequest) r0 
(assert true)
(define-const var1336 String (getService/-1311689935 var2737)) ; Statement: $r4 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>() 
(assert true)
(define-const var3760 String (getService/-1311689935 var2540)) ; Statement: $r3 = virtualinvoke r2.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>() 
(assert true)
(define-const var2622 Bool (= var1336 var3760)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: if $z1 != 0 goto $r6 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>() 
(assert (not (not (= (ite var2622 1 0) 0)))) ; Negate: Cond: $z1 != 0  
 ; Statement: return 0 
(check-sat)
; {cast-from-var2342-to-var3876=([io.grpc.health.v1.HealthCheckRequest], java.lang.Object), cast-from-var3876-to-var2342=([java.lang.Object], io.grpc.health.v1.HealthCheckRequest), getService/-1311689935=([io.grpc.health.v1.HealthCheckRequest], java.lang.String)}
; {var2342=io.grpc.health.v1.HealthCheckRequest, var2737=r1, var3876=java.lang.Object, var1379=r0, var2337=$z0, var2540=r2, var1336=$r4, var3760=$r3, var2622=$z1}
; {io.grpc.health.v1.HealthCheckRequest=var2342, r1=var2737, java.lang.Object=var3876, r0=var1379, $z0=var2337, r2=var2540, $r4=var1336, $r3=var3760, $z1=var2622}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: io.grpc.health.v1.HealthCheckRequest;	r0 := @parameter0: java.lang.Object;	if r0 != r1 goto $z0 = r0 instanceof io.grpc.health.v1.HealthCheckRequest;	$z0 = r0 instanceof io.grpc.health.v1.HealthCheckRequest;	if $z0 != 0 goto r2 = (io.grpc.health.v1.HealthCheckRequest) r0;	r2 = (io.grpc.health.v1.HealthCheckRequest) r0;	$r4 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>();	$r3 = virtualinvoke r2.<io.grpc.health.v1.HealthCheckRequest: java.lang.String getService()>();	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	if $z1 != 0 goto $r6 = virtualinvoke r1.<io.grpc.health.v1.HealthCheckRequest: com.google.protobuf.UnknownFieldSet getUnknownFields()>();	return 0
;block_num 4
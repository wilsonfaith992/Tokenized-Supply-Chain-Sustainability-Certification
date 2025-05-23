;; Entity Verification Contract
;; Validates supply chain participants

(define-data-var admin principal tx-sender)

;; Entity types: 1 = Supplier, 2 = Manufacturer, 3 = Distributor, 4 = Retailer, 5 = Auditor
(define-map entities
  { entity-id: (string-ascii 36) }
  {
    owner: principal,
    name: (string-ascii 100),
    entity-type: uint,
    location: (string-ascii 100),
    verified: bool,
    registration-date: uint
  }
)

(define-read-only (get-entity (entity-id (string-ascii 36)))
  (map-get? entities { entity-id: entity-id })
)

(define-read-only (is-entity-verified (entity-id (string-ascii 36)))
  (default-to false (get verified (get-entity entity-id)))
)

(define-public (register-entity
    (entity-id (string-ascii 36))
    (name (string-ascii 100))
    (entity-type uint)
    (location (string-ascii 100))
  )
  (let ((current-time (unwrap-panic (get-block-info? time (- block-height u1)))))
    (begin
      (asserts! (and (> entity-type u0) (<= entity-type u5)) (err u1)) ;; Valid entity type
      (asserts! (is-none (get-entity entity-id)) (err u2)) ;; Entity ID must be unique
      (ok (map-set entities
        { entity-id: entity-id }
        {
          owner: tx-sender,
          name: name,
          entity-type: entity-type,
          location: location,
          verified: false,
          registration-date: current-time
        }
      ))
    )
  )
)

(define-public (verify-entity (entity-id (string-ascii 36)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u3)) ;; Only admin can verify
    (asserts! (is-some (get-entity entity-id)) (err u4)) ;; Entity must exist
    (ok (map-set entities
      { entity-id: entity-id }
      (merge (unwrap-panic (get-entity entity-id)) { verified: true })
    ))
  )
)

(define-public (transfer-entity-ownership (entity-id (string-ascii 36)) (new-owner principal))
  (let ((entity (unwrap! (get-entity entity-id) (err u4))))
    (begin
      (asserts! (is-eq tx-sender (get owner entity)) (err u5)) ;; Only current owner can transfer
      (ok (map-set entities
        { entity-id: entity-id }
        (merge entity { owner: new-owner })
      ))
    )
  )
)

(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u3)) ;; Only current admin can change admin
    (ok (var-set admin new-admin))
  )
)

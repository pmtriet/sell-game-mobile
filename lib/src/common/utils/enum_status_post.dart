enum PostStatus { selling, sold, pending, rejected, deleted }

String getPostStatus(PostStatus type) {
  switch (type) {
    case PostStatus.selling:
      return 'PUBLIC';
    case PostStatus.sold:
      return 'SOLD';
    case PostStatus.pending:
      return 'PENDING';
    case PostStatus.rejected:
      return 'REJECTED';
    case PostStatus.deleted:
      return 'DELETED';
    default:
      return 'PUBLIC';
  }
}

PostStatus returnPostStatus(String type) {
  switch (type) {
    case 'PUBLIC':
      return PostStatus.selling;
    case 'SOLD':
      return PostStatus.sold;
    case 'PENDING':
      return PostStatus.pending;
    case 'REJECTED':
      return PostStatus.rejected;
    case 'DELETED':
      return PostStatus.deleted;
    default:
      return PostStatus.selling;
  }
}
